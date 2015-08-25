# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @EngineerClass

  constructor: () ->
    @skills_form_num = 0
    @status_form_num = 0
    bind_events.call @
    initialize.call @

  initialize = () ->
    $("tr[id^=skills_]").each () ->
      num = $(this).attr("id").match(/\d+/)[0]
      @skills_form_num = num if @skills_form_num < num

  bind_events = () ->
    if location.pathname == '/engineers/new'
      $("[id^=skills_]").change (el) ->
        add_language_form(el,'#skills_parent')
    else if location.pathname == '/' || location.pathname == '/search'
      $("#add-search-form-skills").click (el) ->
        skill_num = get_num('skills')
        unless $("#skills_#{skill_num}_id").val() > 0 && $("#skills_#{skill_num}_year").val() > 0 && $("#skills_#{skill_num}_level").val() > 0
          alert('ドロップダウンを選択してください')
        else
          add_language_form(el,'#skills-parent')
      $("#add-search-form-statuses").click (el) ->
        status_num = get_num('statuses')
        unless $("#statuses_#{status_num}_job").val() > 0 && $("#statuses_#{status_num}_desire").val() > 0
          alert('ドロップダウンを選択してください')
        else
          add_status_form(el,'#statuses-parent')

  #todo create common processing function add_language_form and add_status_form
  add_language_form = (el,append_selector) ->
    skill_num = get_num('skills')
    if $("#skills_#{skill_num}_id").val() > 0 && $("#skills_#{skill_num}_year").val() > 0 &&
      $("#skills_#{skill_num}_level").val() > 0 && $("[id=skills_#{skill_num}]").length == 1
        el = $("#skills_#{skill_num}").clone()
        skill_num = parseInt(skill_num) + 1
        $(el.find("#skills_#{skill_num - 1}_id")[0]).attr('id',"skills_#{skill_num}_id").attr('name',"skills[#{skill_num}][id]")
        $(el.find("#skills_#{skill_num - 1}_year")[0]).attr('id',"skills_#{skill_num}_year").attr('name',"skills[#{skill_num}][year]")
        $(el.find("#skills_#{skill_num - 1}_level")[0]).attr('id',"skills_#{skill_num}_level").attr('name',"skills[#{skill_num}][level]")
        el.attr('id',"skills_#{skill_num}")
        $(append_selector).append(el)

  add_status_form = (el,append_selector) ->
    status_num = get_num('statuses')
    if $("#statuses_#{status_num}_job").val() > 0 && $("#statuses_#{status_num}_desire").val() > 0 && $("[id=statuses_#{status_num}]").length == 1
        el = $("#statuses_#{status_num}").clone()
        status_num = parseInt(status_num) + 1
        $(el.find("#statuses_#{status_num - 1}_job")[0]).attr('id',"statuses_#{status_num}_job").attr('name',"statuses[#{status_num}][job]")
        $(el.find("#statuses_#{status_num - 1}_desire")[0]).attr('id',"statuses_#{status_num}_desire").attr('name',"statuses[#{status_num}][desire]")
        el.attr('id',"statuses_#{status_num}")
        $(append_selector).append(el)

  get_num = (type) ->
    num = 0
    $("[id^=#{type}_]").each (i,el) ->
      match_data = el.id.match(/\d+/)
      num = match_data[0] if match_data != null && num < match_data[0]
    num


  debug = () ->
    skill_num = get_num('skills')
    c "=== debug ==="
    c "id:#{$("#skills_#{skill_num}_id").val() > 0}"
    c "year:#{$("#skills_#{skill_num}_year").val() > 0}"
    c "level:#{$("#skills_#{skill_num}_level").val() > 0}"
    c "length:#{$("[id=skills_#{skill_num}]").length == 1}"

$ ->

window.engineersClass = new EngineerClass
