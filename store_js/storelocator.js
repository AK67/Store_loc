function showOnGmap(daddr)
{  var saddr = $('#saddr').val();
    window.location="https://www.google.co.in/maps/preview?oe=utf-8&client=-a&channel=sb&ie=UTF-8&gl=in&daddr="+daddr + "&saddr="+saddr;
}

 // function to set breadcrums on find your store 
function setBreadCrums_FS(searchstr)
{ if (searchstr.indexOf(',') != -1)  // searching if comma is present
	{  links =searchstr.split(',');      //spliting string
	  state = links[1];
	  city =  links[0];
	  if( state.length==2)
	  {   state =state.toUpperCase(); 
    	  fullnameState = getStateValue(state);    // if valid state
	      if(state!=fullnameState)
		  { 
		     $("#stateLink_FS").html(fullnameState);
			 $("#cityLink_FS").html(city); 
		  }
	      
	  }
	}
	else
	{     // if entered string is a valid state then add state to breadcrums
	
    	state = searchstr;
		 state =state.toUpperCase();
		fullnameState = getStateValue(state); 
		 if(state!=fullnameState)
			  { 
				 $("#stateLink_FS").html(fullnameState);
				 $("#cityLink_FS").html(""); 
			  }
	}
}
// function to add full state name to breadcrums on store details page
function setStateLink_SD(state){
  state=getStateValue(state);
  $('#stateLink_SD').html(state);
}



function sethiddenId(Id){ 
	document.getElementById('hiddenId').value = Id;
}

// to close eamil popup Modal
function closepopUP_EP() {  
	document.getElementById('emailoverlay').style.display='none';
	document.getElementById('fade').style.display='none';
}

//to show EMail popup modal
function showpopUP_EP() {  
  document.getElementById('emailoverlay').style.display='block';
  document.getElementById('fade').style.display='block';
}

// send email to the passed emailId param
function newEmailer(storeId,emailId,notes) {    
	if(emailId.trim() != '' && emailId.indexOf("@") >= 0 && storeId != '') { 
		$.ajax({		
			type: "GET",		
			cache: false,		
			url: "/store/account/storefetcherdroplet.jsp?email=yes&storeId="+storeId+"&emailId="+emailId+"&notes="+notes,
			contentType: "text/html",
			success: function() {
				closepopUP_EP();
				alert("email sent");
			}		
		});
	} else {
		alert("Please provide valid inputs");
	}
}

// navigate through breadcrums on store details page
function storeDetailsBread(searchstr) {
	var url = '/store/account/findyourstore.jsp?searchterm='+searchstr+'&distlimit=50';
	location.href=url;
}

/* Removed spaces and added encoded characters */
function encodeURLText(url) {
	var encodedUrl = encodeURIComponent(url);
	return encodedUrl;
}

/* Decode the encoded characters */
function decodeURLText(url) {
	var decodedUrl = decodeURIComponent(url);
	return decodedUrl;
}

/* Method generates a pop up window for email options */
function getEmailPopup(name ,id,lat,lng,address1,city,state) { 	 
	$.ajax({		
		type: "GET",		
		cache: false,		
		url: "/store/account/emailPopup.jsp",
		contentType: "text/html",
		data: { name: name, address1: address1,lat:lat,lng:lng,city:city,state:state,id:id },
		success: function(data, xhr, options){ 
			document.getElementById("emailPopupModal").innerHTML=data;
		}		
	});
}

/* Method sends an email to user */
function emailer(strtlat, strtlng, endlat, endlng, storeid) {   
	$.ajax({		
		type: "GET",		
		cache: false,		
		url: "/store/account/storefetcherdroplet.jsp?email=yes&startLat="+strtlat+"&startLng="+strtlng+"&endLat="+endlat+"&endLng="+endlng+"&storeid="+storeid,
		contentType: "text/html",
		success: function() { 
			alert("email sent");
		}		
	});
}	

/* Method fetches lat and lng based on address */
/* Parameters destlat and destlng are not required  */
function getlatlng( destlat, destlng,address) { 							   
	var geocoder = new google.maps.Geocoder();
	var askedlat=""
	var askedlng="";
	var result="";
	geocoder.geocode( { 'address': address }, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			askedlat = results[0].geometry.location.lat();
			askedlng = results[0].geometry.location.lng();
			emailer( askedlat ,askedlng,destlat,destlng);
		} else {
			alert("Unable to find address: " + status);
		}			
	});													  
}

/* Methods fetches the parameter name from the string */
function getParameterByName(name) {
	name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
	results = regex.exec(location.search);
	return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

/* Method invokes findyourpage with some set of parameters */
function goback() {
	var url = '/store/account/findyourstore.jsp?searchterm='+getParameterByName('searchterm')+'&distlimit='+getParameterByName('distlimit'); 
	location.href=url;
}

/* Method finds the appropriate icon for the store based on it's name */
function storeIconPoster(storeName) {
	var imgsrc;
	// posting image on storedetails page of store icon according to store name coming from database
	switch(storeName) {
		case "Palais Royal":
			imgsrc="/static/ss/images/storeicons/pr.png";
			break;
		case "Bealls":
			imgsrc="/store/ss/images/storeicons/b.png";
			break;
		case "Peebles":
			imgsrc="/store/ss/images/storeicons/p.png";
			break;
		case "Stage":
			imgsrc="/store/ss/images/storeicons/s.png";
			break;
		case "Goody's":
			imgsrc="/store/ss/images/storeicons/g.png";
			break;	
	}
					
	var elem = document.createElement("img");
	elem.setAttribute("src", imgsrc);
	elem.setAttribute("height", "40");
	elem.setAttribute("width", "32");
	elem.setAttribute("alt", "icon");
	document.getElementById("storeIconHolder").appendChild(elem);		
}	

function showFromContainer(){        
	  $("#fromContainer").toggleClass("fromContainerShown"); 
}
			
/* Initializing map for store details page */		
function initialize(lat, lng, name, add, city, state, zipcode, imgSrc) {
	var cenLatlng = new google.maps.LatLng(lat,lng);
	var myLatlng = new google.maps.LatLng(lat + .0043,lng);
	var myOptions = {
					   zoom: 15,
					   center: myLatlng
					}
	var map = new google.maps.Map(document.getElementById("map-canvas"),myOptions);
	var marker = new google.maps.Marker({
				 	position: cenLatlng,
				 	map: map
				 });
	
	// Start of newly added code block		
	var contentString = '<table class="InfoTable" width="100%">' +
							'<tr>' +
								'<td colspan="3">' +
												'<font color="red"><h1>' + name + '</h1></font>' +
												'<br/>' + add + '' +
												'<br/>' + city + ', ' + state + ' ' + zipcode + '' +
												'<br/> Goto Directions' +
												'  <span onclick="showFromContainer()">| From here </span>' +
												' <div id="fromContainer" width=100%> From : <input type="text" id="saddr" size=14/> <button class="submit" onclick="showOnGmap('+ "'"+add +','+city+"'"+');">Go</button> </div>'+
								'</td>' +
								'<td align="right" rowspan="6" ><img src=' + imgSrc + '  ></td>' +
							'</tr>' +
						'</table>';
	
	var infowindow = new google.maps.InfoWindow({
												content: contentString
												});

	infowindow.open(map,marker);
}

/* Method displays stores based on the option selected by the user */
function showMapBasedonState(state) {
	document.getElementById("StoreHeading").innerHTML = decodeURLText(state) + " Department Store";
	$("#address").val(decodeURLText(state));
	$("#proxyaddress").val(decodeURLText(state));
	$("#user-location").submit();	
}
			
/* Initializing google locator to find default location */	
function initiatlizeLocator() {	
	$('#map').storeLocator({'dataType': 'json'});
	if (navigator.geolocation){
		navigator.geolocation.getCurrentPosition(geo_success, geo_error, {maximumAge:60000, timeout:2000, enableHighAccuracy:true});   
		// add another  function parameter  alongside showPosition which will be automatically call on failure
	}
	else{
		geo_error();
	}
}

/* Method displays an error popup if google locator is not supported by the browser */
function geo_error() {
  alert( " Your browser doesn't support geolocation!");
  var defaultZipcode = "77025";
		  
  $("#address").val(defaultZipcode);
  $("#user-location").submit();
}

/* Method perform further operations with default location  */
function geo_success(position) {
	showPosition(position.coords.latitude, position.coords.longitude);
}

/* Method finds address (city, state and zipcode) and loads the map accordingly */
function showPosition(lat, lng) {
		//variable declarations
		window.lat = lat;
		window.lang = lng;
		
		//latlng is a required parameter for reversegeocoding  and geocoder is class for geocoding and degeocoding
		var latlng = new google.maps.LatLng(window.lat, window.lang);
		geocoder = new google.maps.Geocoder();
		geocoder.geocode({'latLng': latlng}, function(results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				var result = results[0];
				//look for locality tag and administrative_area_level_1
				var city = "";
				var state = "";
				var postalcode="";
				var sublocality ="";
				for(var i=0, len=result.address_components.length; i<len; i++) {
					var resultaddresscomponent = result.address_components[i];
					if(resultaddresscomponent.types.indexOf("locality") >= 0) city = resultaddresscomponent.long_name; // if there is  indexof locality ,assign it to city variable
					if(resultaddresscomponent.types.indexOf("administrative_area_level_1") >= 0) state = resultaddresscomponent.long_name;
					if(resultaddresscomponent.types.indexOf("postal_code") >= 0) postalcode = resultaddresscomponent.long_name;
					if (resultaddresscomponent.types.indexOf("sublocality")>=0)
					{ 
						sublocality = resultaddresscomponent.long_name;
					}
				}
			}
			//display only on success ,no error handling till now
			if(city != '' && state != '') {
				if($("#proxyaddress").val()=="") {  
					var address = "";
					if(postalcode != '') {
						address = postalcode;
					} else if(sublocality != '') {
						address = sublocality;
					} else if(city != '') {
						address = city;
					} else if(state != '') {
						address = state;
					}
					$("#address").val(address);
				} else {  
					$("#address").val($("#proxyaddress").val());
				}
			}
		//	$('#map-container').storeLocator({'dataType': 'json'});
			$("#user-location").submit();
		});
}
		
/* Required for facebook like button */		
(function(d, s, id) {
				  var js, fjs = d.getElementsByTagName(s)[0];
				  if (d.getElementById(id)) return;
				  js = d.createElement(s); js.id = id;
				  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.0";
				  fjs.parentNode.insertBefore(js, fjs);
				}(document, 'script', 'facebook-jssdk'))
						
// function to display buisness hours in required representation format
function parseString(text) {
	var object = $(".buisnness-hours");
	var bDays = text.split(",");
	var str = "<table>";   
	for(i = 0;i < bDays.length;i++) {	
		str = str + "<tr>";
		var strColsData = "";
		var strTimeData = "";
		var cols = bDays[i].split("$$$");							
		strColsData = strColsData + "<td>" + cols[0] + "</td>";
		strColsData = strColsData + "<td> : </td>";
		var timeData = cols[1].split("to");		
		strColsData = strColsData + "<td>" + timeData[0] + "</td>";
		strColsData = strColsData + "<td> - </td>";
		strColsData = strColsData + "<td>" + timeData[1] + "</td>";										
		str = str + strColsData;
		str = str + "</tr>";										
	}
	str = str + "</table>";   
	$(".buisnness-hours").append(str);
	$(".buisnness-hours").removeClass("buisnness-hours");
	$(".buisnness-hours").addClass("buisnness-hours1");
}

/* Validating if textbox value contains only number */
function numericFilter(value) {
   return !isNaN(parseFloat(value)) && isFinite(value);
}

/* Validating if textbox contains only characters and single comma */
function stringFilter(value) {
  var regex = /^[a-zA-Z ,]*$/;
  if (regex.test(value)) {
      return true;
  }
}