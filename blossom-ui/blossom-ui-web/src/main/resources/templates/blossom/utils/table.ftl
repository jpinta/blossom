<#import "/spring.ftl" as spring>
<#import "/blossom/utils/pagination.ftl" as pagination />
<#import "/blossom/utils/sortable.ftl" as sortable/>
<#import "/blossom/utils/icon.ftl" as icon/>

<#macro table page columns iconPath="" tableId="">
<div class="table-responsive">
  <table class="table table-striped items" <#if tableId?has_content>id="${tableId}"</#if>>
    <thead>
      <#list columns as name, properties>
      <th>
        <#if properties.sortable?? && properties.sortable>
          <#assign sortOrder = (page.sort??)?then((page.sort.getOrderFor(name)??)?then(page.sort.getOrderFor(name).getDirection().name(),""),"")/>
          <@sortable.icon name=name order=sortOrder/>
        </#if>
    	    		<@spring.messageText properties.label properties.label />
      </th>
      </#list>
    </thead>
    <tbody>
      <#if page.content?size == 0>
      <tr>
        <td colspan="${columns?size}">
          <div
            class="alert alert-default text-center"><@spring.message "list.no.element.found.label" /></div>
        </td>
      </tr>
      <#else>
        <#list page.content as item>
        <tr id="item_${item.id?c}">
          <#list columns as name, properties>
            <td class="${name}_property">
              <#if properties.link??>
              <a id="item_${item.id?c}_link" class="text-primary clickable"
                <#if item.code??>
                 name="item_code_${item.code}_link"
                </#if>

                <#assign itemId = item.id/>
                <#if properties.nestedIdPath??>
                  <#assign resultId = item/>
                  <#list properties.nestedIdPath as pathItem>
                    <#assign resultId = resultId[pathItem]/>
                  </#list>
                  <#assign itemId = resultId/>
                </#if>
                 href="<@spring.url relativeUrl=properties.link id=itemId />">
              <strong>
              </#if>

              <!-- Icon -->
              <#if name?index == 0>
                <#if iconPath?has_content && iconPath?is_sequence>
                  <#assign result = item/>
                  <#list iconPath as pathItem>
                    <#assign result = result[pathItem]/>
                  </#list>
                  <@icon.default icon=result/>
                </#if>

                <#if iconPath?has_content &&  iconPath?is_string>
                  <@icon.default icon=iconPath/>
                </#if>
              </#if>

              <!-- Value -->
              <#if properties.nestedPath??>
                <#if properties.nestedPath?has_content && properties.nestedPath?is_sequence>
                  <#assign result = item/>
                  <#list properties.nestedPath as pathItem>
                    <#if result[pathItem]??>
                      <#assign result = result[pathItem]/>
                    </#if>
                  </#list>

                  <@displayProperty value=result type=properties.type label=properties.label/>
                </#if>

                <#if properties.nestedPath?has_content && properties.nestedPath?is_string>
                  <@displayProperty value=item[properties.nestedPath] type=properties.type label=properties.label/>
                </#if>
              <#else>
                <@displayProperty value=item[name] type=properties.type label=properties.label/>
              </#if>

              <#if properties.link??>
              </strong></a>
              </#if>
            </td>
          </#list>
        </tr>
        </#list>
      </#if>
    </tbody>
  </table>
</div>
</#macro>

<#macro pagetable page columns label facets=[] filters=[]  iconPath="" searchable=false q="" tableId="">
<div class="ibox float-e-margins">
  <div class="ibox-title">
    <h5><@spring.messageText label label/></h5>
    <div class="ibox-tools">
      <a class="collapse-link">
        <i class="fa fa-chevron-up"></i>
      </a>
    </div>
  </div>

  <div class="ibox-content">
    <div class="row table-search">
      <div class="col-sm-9 m-b-xs">
        <@displayFacets facets=facets filters=filters/>
      </div>
      <div class="col-sm-3">
        <#if searchable>
          <div class="input-group">
            <input type="text"
                   placeholder="<@spring.message "list.searchbar.placeholder"/>"
                   class="table-search input-sm form-control"
                   onkeyup="var which = event.which || event.keyCode;if(which === 13) {$(this).closest('.row.table-search').find('button.table-search').first().click();}"
              <#if q?has_content> value="${q}"</#if>
            />

            <span class="input-group-btn">
                <button type="button"
                        class="btn btn-sm btn-primary table-search"
                        onclick="var value = $(this).closest('.input-group').children('input.table-search').first().val();var resetPage = $.updateQueryStringParameter(window.location.href,'page',0); var filters = buildFilters(resetPage); window.location.href = $.updateQueryStringParameter(filters,'q', value);">
                    <i class="fa fa-search"></i>
                </button>
              </span>
          </div>
        </#if>

      </div>
    </div>
    <@table page=page columns=columns iconPath=iconPath tableId=tableId/>
  </div>

  <footer class="ibox-footer">
    <div class="row">
      <div class="col-sm-4 hidden-xs">
      </div>
      <div class="col-sm-4 text-center">
        <@pagination.renderPosition page=page label=label/>
      </div>
      <div class="col-sm-4 text-right text-center-xs">
        <@pagination.renderPagination page=page/>
      </div>
    </div>
  </footer>
</div>
<script>
  var buildFilters = function (location) {
    var filters = [];
    var termFacets = $(".table-search-filter-terms");
    termFacets.each(function (i) {
      var that = $(this);
      var filterValue = "";
      var values = that.select2('data');
      filterValue += that.data("path") + '//' + that.data("type") + '//';
      $.each(values, function (index, value) {
        filterValue += value.id;
        if (index < (values.length - 1)) {
          filterValue += "/";
        }
      });
      filters.push(filterValue);
    });

    var dateFacets = $(".table-search-filter-dates");
    dateFacets.each(function (i) {
      if($(this).data('startDate') === undefined) {
          $(this).data("startDate", "");
      }
      if($(this).data('endDate') === undefined) {
          $(this).data("endDate", "");
      }
      filters.push($(this).data("path") + '//' + $(this).data("type") + '//' + $(this).data('startDate') + '/' + $(this).data('endDate'));
    });
    return $.updateQueryStringParameter(location, 'filters', filters.join(";"));
  };

  $(document).ready(function () {
    $(".table-search-filter-terms").each(function (index) {
      var that = $(this);
      that.select2({
        closeOnSelect: false
      });
      var params = $.getQueryParameters();
      var filterParams = params.filters;
      if (filterParams) {
        var filters = filterParams.split(';');
        $.each(filters, function (index, value) {
          var filterPathAndValues = value.split("//");
          if (filterPathAndValues.length == 3) {
            if (filterPathAndValues[0] === that.data("path") && filterPathAndValues[1] === that.data("type") && filterPathAndValues[2].length > 0) {
              that.val(filterPathAndValues[2].split("/"));
              that.trigger('change');
            }
          }
        });
      }
    });

    $(".table-search-filter-dates").each(function (index) {
      var that = $(this);
      that.daterangepicker({
        "timePicker": true,
        "timePicker24Hour": true,
        "applyClass": "btn-primary",
        "autoUpdateInput": false,
        "opens": "center",
        "locale": {
          "format": "<@spring.message "dateformat"/>",
          "separator": " - ",
          "applyLabel": "<@spring.message "apply"/>",
          "cancelLabel": "<@spring.message "cancel"/>",
          "fromLabel": "<@spring.message "from"/>",
          "toLabel": "<@spring.message "to"/>",
          "customRangeLabel": "Custom",
          "weekLabel": "W",
          "daysOfWeek": [
            "<@spring.message "sunday"/>",
            "<@spring.message "monday"/>",
            "<@spring.message "tuesday"/>",
            "<@spring.message "wednesday"/>",
            "<@spring.message "thursday"/>",
            "<@spring.message "friday"/>",
            "<@spring.message "saturday"/>"
          ],
          "monthNames": [
            "<@spring.message "january"/>",
            "<@spring.message "february"/>",
            "<@spring.message "march"/>",
            "<@spring.message "april"/>",
            "<@spring.message "may"/>",
            "<@spring.message "june"/>",
            "<@spring.message "july"/>",
            "<@spring.message "august"/>",
            "<@spring.message "september"/>",
            "<@spring.message "october"/>",
            "<@spring.message "november"/>",
            "<@spring.message "december"/>"
          ],
          "firstDay": 1
        }
      });
      that.on('apply.daterangepicker', function (ev, picker) {
        $(this).val(picker.startDate.format('<@spring.message "dateformat"/>') + ' - '
          + picker.endDate.format('<@spring.message "dateformat"/>'));
        $(this).data("startDate", picker.startDate.valueOf());
        $(this).data("endDate", picker.endDate.valueOf());
      });
      that.on('cancel.daterangepicker', function (ev, picker) {
        $(this).val('');
        $(this).data("startDate", "");
        $(this).data("endDate", "");
      });

      var params = $.getQueryParameters();
      var filterParams = params.filters;
      if (filterParams) {
        var filters = filterParams.split(';');
        $.each(filters, function (index, value) {
          var filterPathAndValues = value.split("//");
          if (filterPathAndValues.length == 3) {
            if (filterPathAndValues[0] === that.data("path") && filterPathAndValues[1] === that.data("type") && filterPathAndValues[2].length > 0) {
              var values = filterPathAndValues[2].split("/");
              if (values[0]) {
                that.data("startDate", values[0]);
                that.data('daterangepicker').setStartDate(moment(values[0], "x"));
              }else{
                that.data("startDate", "");
              }
              if (values[1]) {
                that.data("endDate", values[1]);
                that.data('daterangepicker').setEndDate(moment(values[1], "x"));
              }else{
                that.data("endDate", "");
              }
              if(values[0] && values[0].length > 0 && values[1] && values[1].length > 0) {
                that.val(moment(values[0], "x").format('<@spring.message "dateformat"/>') + ' - ' + moment(values[1], "x").format('<@spring.message "dateformat"/>'));
              }
            }
          }
        });
      }
    });

    $(".table-search-filter").show();
  });
</script>
</#macro>


<#macro displayFacets facets=[] filters=[]>
<div class="row">
  <#list facets as facet>
    <#if facet??>
      <div class="col-sm-6 col-md-4 col-lg-3">
        <#if facet.type == 'TERMS'>
          <@displayTermsFacet facet=facet/>
        <#elseif facet.type == 'DATES'>
          <@displayDatesRangeFacet facet=facet/>
        <#else>
          Unmanaged facet type
        </#if>
      </div>
    </#if>
  </#list>
</div>
</#macro>

<#macro displayTermsFacet facet>
<select class="table-search-filter table-search-filter-terms form-control" multiple="multiple"
        data-path="${facet.path}"
        data-type="${facet.type}"
        data-placeholder="<@spring.messageText facet.name facet.name />" style="display:none;">
  <#list facet.results as result>
    <option value="${result.value}">${result.term} (${result.count?c})</option>
  </#list>
</select>
</#macro>


<#macro displayDatesRangeFacet facet>
<input class="table-search-filter table-search-filter-dates form-control"
       data-path="${facet.path}"
       data-type="${facet.type}"
       type="text"
       placeholder="<@spring.messageText facet.name facet.name />"/>
</#macro>

<#macro displayProperty value="" label="" type="" >
  <#if type?has_content>
    <#if type == "localdate">
      <#if value?? && !(value?is_string)>${value?date("yyyy-MM-dd")}</#if>
    </#if>
    <#if type == "date">
      <#if value?? && !(value?is_string)>${value?date}</#if>
    </#if>
    <#if type == "time">
      <#if value?? && !(value?is_string)>${value?time}</#if>
    </#if>
    <#if type == "datetime">
      <#if value?? && !(value?is_string)>${value?datetime}</#if>
    </#if>
    <#if type == "boolean">
      <#if value?? && !(value?is_string)><@spring.message value?string('yes','no')/></#if>
    </#if>
    <#if type == "enum">
      <#assign enumLabel = "${label}.${value.toString()}.label" />
      <@spring.messageText enumLabel, value.toString() />
    </#if>
    <#if type == "list">
    <ul>
      <#list value as val>
        <li>${val}</li>
      </#list>
    </ul>
    </#if>
  <#else>
  ${value!""}
  </#if>
</#macro>
