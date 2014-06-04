Sm = (function () {
	function Sm(account, user) {
		this.account = account;		
		this.user = user;		
	}
	Sm.prototype.users = [];
	Sm.prototype.getUserFollowings = function() {
		this.getFollowing(0);
	};
	Sm.prototype.getUserFollowers = function() {
		this.getFollowers(0);
	};
	Sm.prototype.getFriends = function() {
		this.getFollowers(0);
	};
	Sm.prototype.addToUsers = function(accounts) {
		this.users = this.users.concat(accounts);
	};
	Sm.prototype.recognize = function (response) {
		var _this = this;
		var users = [];
		accounts = $(response).find(".Grid-cell");
		$.each(accounts, function(index, a) {
			id = $(a).find(".js-stream-item").attr("data-item-id");
			handle = $(a).find(".u-linkComplex-target").text();
			image = $(a).find("img").attr("src"); 
			name = $(a).find(".js-action-profile-name").text();
			bio = $(a).find(".ProfileCard-bio").text();
			following = $(a).find(".FollowStatus").text();
			users.push({
				id: id,
				handle: handle,
				image_url: image,
				name: name,
				bio: bio,
				following: following,
			})
		});
		return users;
	};
	Sm.prototype.post = function (url) {
		$.post("http://127.0.0.1:3000/api/users/" + this.user + "/get_info", {accounts: this.users, account: this.account, type: 'following', url: url});
	}
	Sm.prototype.getFollowing = function(cursor) {
		var _this = this;
		if (cursor != 0) {cursorString = "cursor=" + cursor + "&"} else {cursorString = ""};
		url = "https://twitter.com/" + _this.account + "/following/users?" + cursorString + "cursor_index=&cursor_offset=&include_available_features=1&include_entities=0&is_forward=true";
		request = $.ajax({url: url, dataType: 'html'}).always(function(response) {
			data = JSON.parse(response);
			_this.addToUsers(_this.recognize(data.items_html));
			if (data.has_more_items == true) {
				_this.getFollowing(data.cursor);
			} else {
				_this.post(url);
				return 500;
			}
		});
	}
	Sm.prototype.getFollowers = function(cursor) {
		var _this = this;
		if (cursor != 0) {cursorString = "cursor=" + cursor + "&"} else {cursorString = ""};
		url = "https://twitter.com/" + _this.account + "/followers/users?" + cursorString + "cursor_index=&cursor_offset=&include_available_features=1&include_entities=1&is_forward=true";
		request = $.ajax({url: url, dataType: 'html'}).always(function(response) {
			data = JSON.parse(response);
			window.a = data;
			_this.addToUsers(_this.recognize(data.items_html));
			if (data.has_more_items == true) {
				_this.getFollowers(data.cursor);
			} else {
				_this.post(url);
			}
		});
	}
	return Sm;
})();

//------
accountData = {};
getUser = function(people, celebrities, user) {
	$.each(people, function(index, account) {
		(new Sm(account, user)).getUserFriends();
	});	
	$.each(celebrities, function(index, account) {
		(new Sm(account, user)).getUserFollowers();
	});	
}

people = [];
celebrities = ["CobbsComedyClub", "masonlazarus"];
user = 3;
getUser(people, celebrities, user);