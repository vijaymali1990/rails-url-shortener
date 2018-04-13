class window.URLMappers
  constructor: () ->
    self = @

    $('body').on 'click', '.submit-original-url', ->
      self.generate_url()

  generate_url: () ->
    self = @
    original_url = $('#original-url').val()

    $.ajax
      url: '/url_mapper/short_url'
      data:
        original_url: original_url
      type: 'GET'
      success: (data) ->
        $('#original-url').val(data.short_url)

        if data.new
          $(".products-list").append("<li class='item'>
            <div class=''>
              <span class='col-sm-8'>
                <a style='color:#000;' href=#{data.short_url} class=''>#{data.short_url}</a>
              </span>
              <span class='col-sm-4'>
                <a style='color:#000;' href=#{data.short_url} class=''>
                  <span class='label label-warning'>#{data.url.search_count}</span>
                </a>
              </span>
            </div>")
