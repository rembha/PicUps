/**
 *  ExtendedSpentTimePlugin
 *  
 *  Espace de nom destiné au code du plugin redmine_extended_spent_time
 **/
var PicUpsPlugin = {};

/**
 *  ExtendedSpentTimePlugin.OptionsDisplayWidget
 *
 *  Mise en place des options d'affichage du block Timelog
 *
 **/
PicUpsPlugin.OptionsDisplayWidget = Class.create({
  
  initialize: function(url) {
	this.base_url = url;
	$$('.spent-time-options-container a.select-link').each(function(link){
		link.observe("click", this._updateDisplay.bindAsEventListener(this));
	}.bind(this))
  },
  
  _updateDisplay: function(event){
    event.stop();
    var period = event.findElement('a').identify().gsub("w", "") * 7;
    new Ajax.Updater("my_pics", this.base_url + "?period="+period, {
      onComplete : function(){
		this.initialize(this.base_url);
      }.bind(this)
    });
  }
});
