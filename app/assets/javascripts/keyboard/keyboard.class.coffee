#= require_tree ../templates
class window.FARMA.Keyboard

  @preLoad: (id) ->
    obj = $(document).find("#keyboard-panel-#{id}")
    if obj.hasClass("keyboard-active")
      $("#keyboard-#{id}").show()
    else
      new window.FARMA.Keyboard(id)

  constructor: (id) ->
    self = $("#keyboard-panel-#{id}")
    @id = id
    @screen = new window.FARMA.Screen()
    # @hbs = new window.FARMA.Hbs()
    @tries = self.data("tries")

    Handlebars.registerHelper 'log', (context) ->
      console.log context

    keyboard = HandlebarsTemplates['keyboard']({
          id: id
          tries: @tries
          operators: window.FARMA.Keys.operators()
          keys: window.FARMA.Keys.keys()
          specialKeys: window.FARMA.Keys.specialKeys()
          functions: window.FARMA.Keys.functions()
          matrix: window.FARMA.Keys.matrix()
          trig: window.FARMA.Keys.trig()
    })

    self.html keyboard
    self.addClass("keyboard-active")
    self.show()
    @clickHandler()
    @hotKeyHandler()
    # @checkAnswer()
    @onSubmit()

  clickHandler: ->
    id = @id
    self = @screen

    $(document).on 'click', "#keyboard-#{id} .key", (e) ->
      if $(@).attr('data-value') != 'send'
        self.addToJax($(@).text(), $(@).attr("data-value"), id)
      if $(@).attr('data-value') == 'C'
        self.cleanScreen(id)

    $(document).on 'click', '#special-keys ul li', ->
      $('#special-keys ul li').removeClass('active');
      $(@).addClass('active')
      $('#advanced-keys div').hide();
      show_id = "#" + $(@).data('id')
      $(show_id).show()

    thisKB = @
    $(document).on 'click', "#keyboard-panel-#{id} #show-direct-input", ->
      editor = $("#keyboard-panel-#{id} .direct-input")
      editor.toggleClass('hide')
      $("#keyboard-#{id}").toggleClass('make-tall')
      unless editor.hasClass('active')
        thisKB.renderEditor()
        editor.addClass('active')

  onSubmit: (editor) ->
    id = @id
    self = @screen

    $("#keyboard-#{id} button[type='submit']").on 'click', ->
      if editor
        editor.toTextArea()

      $("#keyboard-#{id}").hide()
      # $("#question_#{id}_response").attr("data-storage", $("#keyboard-#{id}-screen").val())
      # $("#question_#{id}_response").val($("#keyboard-#{id}-screen").val())
      $("#question-#{id}-show .box-response").show()

      response_container = $("#keyboard-panel-#{id}").data('response-container')
      $.post
        url: $("#keyboard-panel-#{id}").data('bucket')
        data: {
          answer: {
            response: $("#keyboard-#{id}-screen").val()
            }
          }
        dataType: "json",
        success: (data) ->
          $(response_container).html(data.response)
          $(response_container).removeClass('invalid').removeClass('valid');
          cssClass = if data.correct_answer then 'valid' else 'invalid'
          $(response_container).addClass(cssClass);

  hotKeyHandler: ->
    self = @screen
    id = @id
    $(document).on 'keydown', "#keyboard-#{id}-screen", (e) ->
      unless e.key.length != 1
        switch e.key
          when 'Backspace' then console.log 'backspace'
          when 'C' then self.cleanScreen(id)
          else self.addToJax(e.key, e.key, id)

  renderEditor: ->
    editor = CodeMirror.fromTextArea(document.getElementById("keyboard-#{@id}-screen"), {
      height: "150px",
      parserfile: "stex.js",
      path: "codemirror/js/",
      textWrapping: true,
      lineNumbers: true,
      theme: "material"
    })
    @onSubmit(editor)
