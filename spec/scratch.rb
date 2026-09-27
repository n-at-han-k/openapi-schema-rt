# frozen_string_literal: true
#
# Objects the mutating half of the suite is allowed to wreck.
#
# The read half points at whatever is already in RT -- queue General, user
# root -- and that is fine, because a GET changes nothing. The mutating half
# must NOT: `DELETE /queue/{idOrName}` with idOrName: General disables the
# default queue, and `DELETE /user/{idOrName}` with root locks everyone out
# of the instance. So every mutating example is aimed at something this file
# made, named conformance-<something>-<run id> so it is obvious in the UI
# where it came from.
#
# Created ON DEMAND and re-created after a delete, because the example that
# deletes a queue runs before the one that updates it as often as not, and a
# suite whose examples depend on each other's order is a suite that fails for
# reasons that have nothing to do with the API.

module RT
  module Scratch
    RUN = Time.now.strftime('%Y%m%d-%H%M%S')

    # type => how to make one, and what to call the thing it answers.
    RECIPES = {
      'queue'       => { path: '/queue',       body: -> { { 'Name' => name('queue') } } },
      'group'       => { path: '/group',       body: -> { { 'Name' => name('group') } } },
      'user'        => { path: '/user',        body: -> { { 'Name' => name('user'), 'Password' => 'conformance-suite-password' } } },
      'catalog'     => { path: '/catalog',     body: -> { { 'Name' => name('catalog') } } },
      'class'       => { path: '/class',       body: -> { { 'Name' => name('class') } } },
      'customfield' => { path: '/customfield', body: -> {
        { 'Name' => name('cf'), 'Type' => 'Select', 'MaxValues' => '1',
          'LookupType' => 'RT::Queue-RT::Ticket' }
      } },
      'lifecycle'   => { path: '/lifecycles',  body: -> { { 'Name' => name('lifecycle'), 'Type' => 'ticket' } } },
      'ticket'      => { path: '/ticket',      body: -> { { 'Queue' => fetch('queue'), 'Subject' => name('ticket') } } },
      'asset'       => { path: '/asset',       body: -> { { 'Name' => name('asset'), 'Catalog' => fetch('catalog') } } },
      'article'     => { path: '/article',     body: -> { { 'Name' => name('article'), 'Class' => fetch('class') } } }
    }.freeze

    @made = {}
    @serial = 0

    module_function

    # Unique per CREATION, not per run: RT's delete is a disable, so the name
    # stays taken, and an example that deletes a scratch queue must not make
    # the next one ask for the same name back.
    def name(kind)
      @serial += 1

      # 32 characters, because that is RT's limit on a lifecycle name and
      # there is no reason for the others to be longer. `conf-` rather than
      # `conformance-` for the same reason, and it is still unmistakable in
      # the UI.
      "conf-#{kind}-#{RUN[-6..]}-#{@serial}"[0, 32]
    end

    # The identifier a path parameter should carry for this type, making one
    # if there is not one already.
    def fetch(type)
      @made[type] ||= create(type)
    end

    # After a delete: the next example that needs one makes a new one.
    def forget(type)
      @made.delete(type)
    end

    # The runner knows only the values it was handed, not which kind they
    # were, so a successful delete is matched back by value.
    def forget_by_value(values)
      wanted = values.map(&:to_s)

      @made.delete_if { |_, made| wanted.include?(made.to_s) }
    end

    def create(type)
      recipe = RECIPES.fetch(type) { raise("no scratch recipe for #{type}") }
      response = RT.call('POST', recipe[:path], { 'body' => recipe[:body].call })

      unless %w[200 201].include?(response.status)
        raise "could not make a scratch #{type}: #{response.status} #{response.raw[0, 200]}"
      end

      # A lifecycle has no id: it is addressed by name, and the create
      # answers its whole configuration rather than a reference.
      body = response.body.is_a?(Hash) ? response.body : {}
      id = body['id'] || body['name']
      raise "scratch #{type} came back with nothing to address it by: #{response.raw[0, 200]}" if id.nil?

      id.to_s
    end

    # A custom field value, which only exists inside a custom field.
    def fetch_value
      @made['customfield_value'] ||= begin
        field = fetch('customfield')
        response = RT.call('POST', "/customfield/#{field}/value",
                           { 'body' => { 'Name' => name('value') } })
        raise "could not make a scratch value: #{response.raw[0, 200]}" unless %w[200 201].include?(response.status)

        (response.body.is_a?(Hash) ? response.body['id'] : nil).to_s
      end
    end

    def made
      @made
    end

    # For a body fixture that creates something of its own: every call is a
    # new name.
    def serial
      @serial += 1

      @serial.to_s
    end

    # Everything this run created, taken back down. Best effort: an object an
    # example already deleted is not an error.
    def clean
      ticket = @made['ticket']
      RT.call('PUT', "/ticket/#{ticket}", { 'body' => { 'Status' => 'deleted' } }) if ticket

      asset = @made['asset']
      RT.call('PUT', "/asset/#{asset}", { 'body' => { 'Status' => 'deleted' } }) if asset

      { 'article' => '/article', 'customfield' => '/customfield', 'class' => '/class',
        'catalog' => '/catalog', 'user' => '/user', 'group' => '/group',
        'queue' => '/queue' }.each do |type, path|
        id = @made[type]
        RT.call('DELETE', "#{path}/#{id}", {}) if id
      end

      lifecycle = @made['lifecycle']
      RT.call('DELETE', "/lifecycle/#{lifecycle}", {}) if lifecycle
    rescue StandardError => e
      warn("[scratch] cleanup did not finish: #{e.class}: #{e.message}")
    end
  end
end
