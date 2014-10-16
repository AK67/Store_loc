<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<dsp:page>
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
	<dsp:getvalueof param="page" var="pageName" />
	<ss:pageContainer>
		<jsp:attribute name="title">
			<fmt:message key="profile.findyourstore" />
		</jsp:attribute>
		<jsp:attribute name="pageSpecificCSS">
			<link rel="stylesheet" type="text/css" href="/static/ss/css/storedetails.css" />	
			<link rel="stylesheet" type="text/css" href="/static/ss/css/storecommon.css" />				
		</jsp:attribute>
		<jsp:attribute name="pageSpecificJS">
			<script src="/static/ss/js/handlebars-1.0.0.js"></script>
			<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
			<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
		</jsp:attribute>
		<jsp:body>
			<script src="http://maps.google.com/maps/api/js?sensor=false&region=US"></script>
			<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
			<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
			<script src="/static/ss/js/storelocator.js"></script>
			<div id="fb-root"></div>
			<script></script>
			<dsp:include page="/global/includes/topNav.jsp"/>
			<section id="maincontent">
				<!-- PAGE ADD BANNER -->
				<section class="pageadd-bnr">
					<dsp:include page="/browse/pdp/gadgets/productPromoBanner.jsp"/>
				</section>
				<section id="maincontent-wrapper">
					<!-- BREAD CRUMB STARTS -->
					<dsp:droplet name="com/ss/droplet/GenerateStoreLocatorResponse">
						<dsp:oparam name="serviceError">
							<dsp:valueof param="error" />
						</dsp:oparam>
						<dsp:oparam name="storeDetails">
							<div id="breadcrumbs">
								<c:choose>
									<c:when test="${pageName eq 'signin' || pageName eq null || pageName eq '' }">
										<ul>
											<li><dsp:a href="${ctxPath}/index.jsp" title="home"><fmt:message key="breadcrumbs.home"></fmt:message></dsp:a></li>
											<li> <fmt:message key="profile.findyourstore"/></li>
											<li onclick="storeDetailsBread( '<dsp:valueof param='store.state'/>');"> <dsp:valueof param="store.state"/> </li>
											<li onclick="storeDetailsBread( '<dsp:valueof param='store.city'/>');"> <dsp:valueof param="store.city"/> </li>
											<li class="no-border"><span> <dsp:valueof param="store.name"/></span></li>
										</ul>
									</c:when>
								</c:choose>
							</div>
							
							<!-- END OF BREAD CRUMB -->
							<section id="content-wrapper">
								<div id="store-locator-container">
								<jsp:include page="newEmailPopup.jsp" />
									<div id="page-header">
									</div>
									<table id="coupon-map"> <!-- table with coupon image and static map-->
										<tr>
											<td>
												<img  id="coupon-image" src='<dsp:valueof param="store.promotionImage"  />' class="coupon-image-height" />
											</td>
										</tr>
										<tr>
											<td>
												<div id="map-canvas" style="border: 1px dotted darkblue; width: 400px; height: 400px;">
												<!--
												<img style="border:1px solid black" src='http://maps.googleapis.com/maps/api/staticmap?center=<dsp:valueof param="store.latitude" />,<dsp:valueof param="store.longitude" />&markers=<dsp:valueof param="store.latitude" />,<dsp:valueof param="store.longitude" />&zoom=15&size=400x400&sensor=false' />
												-->
												</div>
											</td>
										</tr>
									</table>
									<script>
									initialize(<dsp:valueof param="store.latitude" />,<dsp:valueof param="store.longitude" />, '<dsp:valueof param="store.name"/>', '<dsp:valueof param="store.address1"/>', '<dsp:valueof param="store.city"/>', '<dsp:valueof param="store.state"/>', '<dsp:valueof param="store.zipcode"/>','<dsp:valueof param="store.couponImage"  />');
									</script>
									<h1><dsp:valueof param="store.name"/>&nbsp;<dsp:valueof param="store.city"/>&nbsp;Department Store</h1>
									<table id='maintable'    >
										<tr>
											<td>
												<table  cellspacing="10"  >
													<tr style="border: 1px solid black">
														<td id="storedetails"   > <!--description and details-->
															<img id='storeimage' src="<dsp:valueof param="store.storeImage"/>" alt="StoreImage" >
															<br>
															<table id="deals">
																<tr>
																	<td>
																		<a href="http://www.stagestores.com/store/todaysDeal" style="text-decoration:none" > <img src="/static/ss/images/storeicons/todaysdeals.png"/> <span class='redfont'><b> Today's Deals </b></span></a>
																	</td>
																	<td style="padding-left:5px;">
																		<div class="fb-like" data-href="https://developers.facebook.com/docs/plugins/" data-layout="button_count" data-action="like" data-show-faces="false" data-share="false"></div>
																	</td>
																</tr>
																<tr>
																	<td colspan=2 id="td_sendaddress">
																		<br/>
																		<p> Send Address to: <a class="redtextunderline "  onclick = 'sethiddenId(<dsp:valueof param="storeId"/>);showpopUP_EP();' href="javascript:void(0)"> E-mail </a> <!--  | <a class="redtextunderline" href="javascript:void(0)"> Mobile </a></p>  -->																	 
																	</td>
																</tr>
															</table>
														</td>
														<td>
														</td>
														<td style="vertical-align:top;">
															<div id="storeIconHolder"> </div>
															<script>
															storeIconPoster('<dsp:valueof param="store.name"/>');														
															</script>
															<!-- SENDEING PARAM TO NEW_EMAIL_POPUP_COMPONENT -->
															
														</td>
														<td >
															<div  >
																<table id="details"  >
																	<tr >
																		<td>
																			<p id="storenameheading">
																			<dsp:valueof param="store.name"/></p>
																		</td>
																	</tr>
																	<tr >
																		<td>
																			<p id="storeaddress">
																			<dsp:valueof param="store.address1"/><br><dsp:valueof param="store.city"/>,<dsp:valueof param="store.state"/><br>
																			</p>
																		</td>
																	</tr>
																	<tr >
																		<td>
																			<h1>Store Manager: </h1 >
																			<dsp:valueof param="store.storeManager"/> <br>
																		</td>
																	</tr>
																	<tr>
																		<td>
																			<h1 >Phone:</h1 >
																			<dsp:valueof param="store.mainPhoneNumber"/> <br>
																		</td>
																	</tr>
																	<tr >
																		<td>
																			<h1 >Hours:</h1 >
																			<table id="buisnesshours">
																				<dsp:droplet name="/atg/dynamo/droplet/ForEach">
																					<dsp:param name="array" param="store.businessDayHours"/>
																					<dsp:oparam name="output">
																						<dsp:getvalueof var="businessHours" param="element" />
																						<c:set var="dayshours" value="${businessHours}" />
																						<c:set var="dayshour" value="${fn:split(dayshours, '=')}"/>
																						<tr>
																							<td><c:out value="${dayshour[0]}" /></td>
																							<td valign="top">&nbsp;:&nbsp;</td>
																							<td valign="top"><c:out value="${dayshour[1]}" /></td>
																						</tr>
																					</dsp:oparam>
																				</dsp:droplet><!-- ForEach -->
																			</table>
																		</td>
																	</tr>
																</table>
															</div>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
									 
									<div id="description">
										<dsp:valueof param="store.description"/><br><br> 
										<p> 
											<span class="redtext"> 
												<a style="text-decoration:none" href='https://d.comenity.net/stagestores/' target="blank">
													<font color=red > Click here</font>
												</a> 
											</span> to apply for a <dsp:valueof param="store.name"/>  to get a credit 
										</p>
									</div>
									<br>
							</section>
							                           
						</dsp:oparam>
						<dsp:oparam name="EmptyListOfSuggestedStores">
							<dsp:valueof param="NOSuggestedStores" />
						</dsp:oparam>
						<dsp:oparam name="ListOfSuggestedStores">
							<table id="storesuggestions">
								<thead>
									<tr bgcolor="grey">
										<th colspan="5" align="left" style="padding:10px; color:white">Other nearby Department store locations</th>
									</tr>
								</thead>
								<tbody id="stateTableBody">
									<dsp:droplet name="/atg/dynamo/droplet/ForEach">
										<dsp:param name="array" param="SuggestedStores"/>
										<dsp:oparam name="output">
											<td style='padding-left:10px;' width='20%'>
												<span class="redtext" style="color:red"><b>  <dsp:valueof param="element.name"/></b></span>
												<br/><dsp:valueof param="element.address1"/>
												<br/><dsp:valueof param="element.city"/>, <dsp:valueof param="element.state"/> <dsp:valueof param="element.zipcode"/>
												<br> <a class="redtextunderline" href='/store/account/storedetails.jsp?storeId=<dsp:valueof param="element.storeid"/>&strtlat=<dsp:valueof param="element.lat"/>&strtlng=<dsp:valueof param="element.lng"/>&searchterm=<dsp:valueof param="searchterm"/>&distlimit=<dsp:valueof param="distlimit"/>'> Store info </a> &nbsp;|&nbsp;<a href="https://www.google.co.in/maps/preview?oe=utf-8&client=firefox-a&channel=sb&ie=UTF-8&gl=in&daddr=<dsp:valueof param='element.address1'/>,<dsp:valueof param='element.city'/>,<dsp:valueof param='element.state'/> &saddr=<dsp:valueof param='element.city'/>,<dsp:valueof param='element.state'/>" target="_blank" >Direction</a>
											</td>
										</dsp:oparam>
									</dsp:droplet>
								</tbody>
								
							</table>
							   

						
						</dsp:oparam>
					</dsp:droplet>
					<br/>
					<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
					<!-- Include all compiled plugins (below), or include individual files as needed -->
					
				</section>
			</section>
			
		</jsp:body>
	</ss:pageContainer>
</dsp:page>