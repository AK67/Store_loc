<dsp:page><dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" /><dsp:getvalueof param="page" var="pageName" /><ss:pageContainer>
<jsp:attribute name="title">
  <fmt:message key="profile.findyourstore" />
</jsp:attribute>
<jsp:attribute name="pageSpecificCSS">
  <link rel="stylesheet" type="text/css" href="/static/ss/css/map.css" />
  <link rel="stylesheet" type="text/css" href="/static/ss/css/storecommon.css" />	
</jsp:attribute>
<jsp:attribute name="pageSpecificJS">
  <script src="/static/ss/js/lib/jquery.js?v=20140610.19.14.34" type="text/javascript"></script>
  <script src="/static/ss/js/handlebars-1.0.0.js"></script>
  <script src="http://maps.google.com/maps/api/js?sensor=false&region=US"></script>
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
  <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
  <script src="/static/ss/js/storelocator.js"></script>
  <script src="/static/ss/js/jquery.storelocator.js"></script>
  <script src="http://connect.facebook.net/en_US/all.js"></script>

  <script>
  $(function() {
          initiatlizeLocator();});
  </script>
</jsp:attribute>

<jsp:body>
                      <div id="fb-root"></div>
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
  <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
  <script src="/static/ss/js/storelocator.js"></script>
  <dsp:include page="/global/includes/topNav.jsp"/>
  <section id="maincontent">
    <!-- PAGE ADD BANNER -->
    <section class="pageadd-bnr">
      <dsp:include page="/browse/pdp/gadgets/productPromoBanner.jsp"/>
    </section>
    <section id="maincontent-wrapper">
      <!-- BREAD CRUMB STARTS -->
      <div id="breadcrumbs"> 
        <c:choose>
          <c:when test="${pageName eq 'signin' || pageName eq null || pageName eq '' }">
            <ul>
              <li><dsp:a href="${ctxPath}/index.jsp" title="home"><fmt:message key="breadcrumbs.home"></fmt:message></dsp:a></li>
              <li > <dsp:a href=""><fmt:message key="profile.findyourstore"/></dsp:a></li>
              <li> <a id="stateLink_FS">  </a> </li>
			  <li> <a id="cityLink_FS">  </a> </li>
            </ul>
          </c:when>
        </c:choose>
      </div>
      <!-- END OF BREAD CRUMB -->
	  <jsp:include page="newEmailPopup.jsp" />
      <section id="content-wrapper">
        <div id="store-locator-container">
          <div id="page-header">
          </div>

          <div id="map-container">
              <table id="maptable" >
                <tr>
                 <td width=30%>
                  <table >
                    <tr>
                      <td >
                        <table width=353>
                          <tr>
                            <td>
                              <h1><span id="StoreHeading">Store Locator<span></h1>

                            </td>
                          </tr>
                          <tr>
                            <td>
                              </br> <p>Our store locator feature brand name,clothing,shoes and accessories for the family from U.S Polo Assn, Levi's, Cater's, Nike, Sketchers, Converse and more. Shop today for great deals</p>
                            </td>
                          </tr>
                          </table>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <div id="form-container">
                          <form id="user-location" method="post" action="#">

                            <div id="form-input">

                              <label for="address">Enter Zip Code or City and State</label><br/>

                                <table>
                                  <tr>

                                    <td >
                                      <input type="text" id="proxyaddress" name="address" style="width:190px"/>
                                    </td>
                                    <td>
                                      <input type="hidden" id="address" name="address" />
                                    </td>
                                    <td>
                                      <button id="submit" type="submit" >Go</button>
                                    </td>
                                    <td style="padding-left:15px">
                                      <select id="distancelimit" name="distancelimit">
                                      <option value="20">20</option>
                                      <option value="40">40</option>
                                      <option value="50" selected="true">50</option>
                                      <option value="80">80</option>
                                      <option value="100" >100</option>
                                    </td>
                                      </select>

                                  </tr>
                                  <tr> <td> <div id="noOfStoresNearby">      </div>  </td> </tr>
                                </table>
                            </div>


                          </form>

                        </div>
                      </td>
                    </tr>
                      <tr>
                      <td>
                        <div id="loc-list">
                          <ul id="list"></ul>
                        </div>
                      </td>
                     </tr>
                  </table>
                </td>
                <td  style="overflow:visible;">
                    <div id="map"></div>
                    <img src="/static/ss/images/loader.gif" id="maploaderimg"  > 
                </td>
              </tr>
            </table>
          </div> 
          <div id="map-footer">
            <table style="BORDER:1px solid grey; z-index: 999;" width="115%" id="stateTable">
              <thead>
                <tr id="tHeader" bgcolor="grey">
                  <th colspan="6" align="left" style="padding:10px; color:white">Find Stage, Goody's, Palais Royal, Peebles department stores by States</th>
                </tr>
              </thead>
              <tbody id="stateTableBody">
              </tbody>

            </table>
          </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
      </section>
    </section>
  </section>
</jsp:body>
</ss:pageContainer>
</dsp:page>
