/*! Fabrik */
var FbListFilter=new Class({Implements:[Options,Events],options:{container:"",type:"list",id:"",advancedSearch:{controller:"list"}},initialize:function(a){this.filters=$H({}),this.setOptions(a),this.advancedSearch=!1,this.container=document.id(this.options.container),this.filterContainer=this.container.getElements(".fabrikFilterContainer"),this.filtersInHeadings=this.container.getElements(".listfilter");var b=this.container.getElement(".toggleFilters");if("null"!==typeOf(b)&&(b.addEvent("click",function(a){var c=b.getPosition();a.stop();c.x-this.filterContainer.getWidth(),c.y+b.getHeight();this.filterContainer.toggle(),this.filtersInHeadings.toggle()}.bind(this)),"null"!==typeOf(this.filterContainer)&&(this.filterContainer.hide(),this.filtersInHeadings.toggle())),"null"!==typeOf(this.container)){this.getList();var c=this.container.getElement(".clearFilters");"null"!==typeOf(c)&&(c.removeEvents(),c.addEvent("click",function(a){var b;a.stop(),this.container.getElements(".fabrik_filter").each(function(a){(a.name.contains("[value]")||a.name.contains("fabrik_list_filter_all")||a.hasClass("autocomplete-trigger"))&&("select"===a.get("tag")?a.selectedIndex=a.get("multiple")?-1:0:"checkbox"===a.get("type")?a.checked=!1:a.value="")}),b=this.getList().plugins,"null"!==typeOf(b)&&b.each(function(a){a.clearFilter()});var c="form"===this.container.get("tag")?this.container:this.container.getElement("form");new Element("input",{name:"resetfilters",value:1,type:"hidden"}).inject(c),"list"===this.options.type?this.list.submit("list.clearfilter"):this.container.getElement("form[name=filter]").submit()}.bind(this))),(advancedSearchButton=this.container.getElement(".advanced-search-link"))&&advancedSearchButton.addEvent("click",function(a){a.stop();var b=a.target;"a"!==b.get("tag")&&(b=b.getParent("a"));var c=b.href;c+="&listref="+this.options.ref,this.windowopts={id:"advanced-search-win"+this.options.ref,title:Joomla.JText._("COM_FABRIK_ADVANCED_SEARCH"),loadMethod:"xhr",evalScripts:!0,contentURL:c,width:710,height:340,y:this.options.popwiny,onContentLoaded:function(){var a=Fabrik.blocks["list_"+this.options.ref];"null"===typeOf(a)&&(a=Fabrik.blocks[this.options.container],this.options.advancedSearch.parentView=this.options.container),a.advancedSearch=new AdvancedSearch(this.options.advancedSearch),d.fitToContent(!1)}.bind(this)};var d=Fabrik.getWindow(this.windowopts)}.bind(this))}},getList:function(){return this.list=Fabrik.blocks[this.options.type+"_"+this.options.ref],"null"===typeOf(this.list)&&(this.list=Fabrik.blocks[this.options.container]),this.list},addFilter:function(a,b){this.filters.has(a)===!1&&this.filters.set(a,[]),this.filters.get(a).push(b)},onSubmit:function(){this.filters.date&&this.filters.date.each(function(a){a.onSubmit()})},onUpdateData:function(){this.filters.date&&this.filters.date.each(function(a){a.onUpdateData()})},getFilterData:function(){var a={};return this.container.getElements(".fabrik_filter").each(function(b){if(b.id.test(/value$/)){var c=b.id.match(/(\S+)value$/)[1];a[c]="select"===b.get("tag")&&-1!==b.selectedIndex?document.id(b.options[b.selectedIndex]).get("text"):b.get("value"),a[c+"_raw"]=b.get("value")}}.bind(this)),a},update:function(){this.filters.each(function(a){a.each(function(a){a.update()}.bind(this))}.bind(this))}});