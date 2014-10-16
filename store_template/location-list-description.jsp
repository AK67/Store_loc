<script>

function fire_SD(id)
{     setURLParameter("storeId",id);
      showpopUP_EP();
     
}
</script>
{{#location}}
<li data-markerid="{{markerid}}" >
	<table  id="listleftdetails"  width="100%" >
    	<tr > 
        	<td style="vertical-align:top;" width="10%"> <div class="list-label"> <p id="list-label-text">{{marker}}  </p> </div> </td>						
			<td    id="td_listleftdetails"  width="53%">   
 				<div class="list-details">
					<div class="list-content" style="font: 11px Arial,Helvetica,sans-serif;">
						<div class="loc-id"><h3>{{name}}</h3></div>			
						<div class="loc-addr1">{{address1}} </div> 	
						<div class="loc-addr3">{{city}} {{state}} {{zipcode}}</div> 
						<div class="loc-phone">Phone:{{mainPhoneNumber}}</div>
						<div class="distance">Distance:{{distance}} miles </div>  	 									
						<div class="buisnness-hours"></div>
						<script>parseString('{{businessDays}}');</script>
						<div class="view-onmap"  data-markerid="{{markerid}}"><a style="color:red">View on map &#9658;</a></div>
						<div class="loc-web"><a href="http://{{web}}" target="_blank">{{web}}</a></div>
                    </div>
				</div>				    
            </td>
                  
			<td id="rightdetails" valign="top" width="37%">   
     			<div >
     				<img src="/static/ss/images/storeicons/todaysdeals.png"/>
     				<a href="http://www.stagestores.com/store/todaysDeal" > <span class='redfont'>Today's Deals </span> </a>
     			</div>
  				<div class="redfont"> 
  					<img src="/static/ss/images/storeicons/storepage.png"/>
  					<a href="/store/account/storedetails.jsp?storeId={{storeid}}&strtlat={{strtlat}}&strtlng={{strtlng}}&searchterm={{searchterm}}&distlimit={{distancelimit}}" style="color:red" >
						Store Page  
					</a> 
				</div>
   				<br/>

    			<p> Send Address to: <br> <span class="redfont"  onclick="var id ='{{storeid}}'; sethiddenId(id);showpopUP_EP();" > E-mail </span> <!-- | <span class="redfont"> Mobile </span>  --> 
	       		<!--<span class="redfont" > E-mail </span> | <span class="redfont"> Mobile </span> -->
				
			  	<br/>
			  	<br/>
	     		<div id="fb">  <fb:like href="{{storePage}}" layout="button_count" action="like" show_faces="false" share="false"></fb:like></div>
	 		</td>
		</tr>
	</table>
</li>


{{/location}}
