/*! Fabrik */
var tablesElement=new Class({Implements:[Options,Events],options:{conn:null},initialize:function(a,b){this.el=a,this.setOptions(b),"null"===typeOf(document.id(this.options.conn))?this.periodical=this.getCnn.periodical(500,this):this.setUp()},cloned:function(){},getCnn:function(){"null"!==typeOf(document.id(this.options.conn))&&(this.setUp(),clearInterval(this.periodical))},setUp:function(){this.el=document.id(this.el),this.cnn=document.id(this.options.conn),this.loader=document.id(this.el.id+"_loader"),this.cnn.addEvent("change",function(){this.updateMe()}.bind(this));var a=this.cnn.get("value");""!==a&&-1!==a&&this.updateMe()},updateMe:function(a){a&&a.stop(),this.loader&&this.loader.show();var b=this.cnn.get("value"),c="index.php",d=new Request({url:c,data:{option:"com_fabrik",format:"raw",task:"plugin.pluginAjax",g:"element",plugin:"field",method:"ajax_tables",cid:b.toInt()},onComplete:function(a){var b=JSON.decode(a);"null"!==typeOf(b)&&(b.err?alert(b.err):(this.el.empty(),b.each(function(a){var b={value:a};a===this.options.value&&(b.selected="selected"),this.loader&&this.loader.hide(),new Element("option",b).set("text",a).inject(this.el)}.bind(this))))}.bind(this),onFailure:function(a){this.el.empty(),this.loader&&this.loader.hide(),alert(a.status+": "+a.statusText)}.bind(this)});Fabrik.requestQueue.add(d)}});