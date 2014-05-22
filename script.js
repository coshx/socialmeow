Sm = (function () {
	function Sm(account, user) {
		this.account = account;		
		this.user = user;		
	}
	Sm.prototype.users = [];
	Sm.prototype.get = function() {
		this.getChunk(0);
	};
	Sm.prototype.recognize = function (response) {
		var _this = this;
		accounts = $(response).find(".Grid-cell");
		$.each(accounts, function(index, a) {
			id = $(a).find(".js-stream-item").attr("data-item-id");
			handle = $(a).find(".u-linkComplex-target").text();
			image = $(a).find("img").attr("src"); 
			name = $(a).find(".js-action-profile-name").text();
			bio = $(a).find(".ProfileCard-bio").text();
			following = $(a).find(".FollowStatus").text();
			_this.users.push({
				id: id,
				handle: handle,
				image_url: image,
				name: name,
				bio: bio,
				following: following,
			})
		});
	};
	Sm.prototype.getChunk = function(cursor) {
		var _this = this;
		if (cursor != 0) {cursorString = "cursor=" + cursor + "&"} else {cursorString = ""};
		url = "https://twitter.com/" + _this.account + "/following/users?" + cursorString + "cursor_index=&cursor_offset=&include_available_features=1&include_entities=0&is_forward=true";
		request = $.ajax({url: url, dataType: 'html'}).always(function(response) {
			data = JSON.parse(response);
			_this.recognize(data.items_html);
			if (data.has_more_items == true) {
				_this.getChunk(data.cursor);
			} else {
				$.post("http://127.0.0.1:3000/api/users/" + _this.user + "/get_info", {accounts: _this.users, account: _this.account, type: 'following', url: url});
			}
		});
	}
	return Sm;
})();

//------

accounts = ["miketweetfeed", "HelveticaFire"];
accountData = {};
$.each(accounts, function(index, account) {
	(new Sm(account, user)).get();
});