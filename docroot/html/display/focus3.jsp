<%@ include file="/init.jsp" %>

<%
	SearchContainer searchContainer = (SearchContainer)request.getAttribute("view.jsp-searchContainer");

	List<AssetEntry> results = (List<AssetEntry>)searchContainer.getResults();

%>

<div class="newsfocus3-wrapper" id='<portlet:namespace/>newsfocus3'>
	<div class="nf3-container">
		<div class="nf3-left-content">
			<div class="box_hot_news" >
				<c:if test="<%= results != null && results.size() > 0 %>">
					<%
						AssetEntry firstEntry = results.get(0);
		
						long firstClassPK = firstEntry.getClassPK();
		
						AssetRenderer firstAssetRenderer = firstEntry.getAssetRenderer();
					%>
		
					<c:if test="<%= firstAssetRenderer != null && firstAssetRenderer.isDisplayable() %>">
						<%
						String firstTitle = StringUtil.shorten(firstAssetRenderer.getTitle(locale), titleLength);

						String firstSmallImage = NewsPublisherUtil.getSmallImagePath(request, firstClassPK);
		
						if(Validator.isNull(firstSmallImage) && useImageDefault){
							firstSmallImage = firstAssetRenderer.getThumbnailPath(renderRequest);
						}
		
						String firstViewContentURL = NewsPublisherUtil.getViewContentURL(request, firstEntry, linkedLayout);
						
						String firstSummary = HtmlUtil.escape(StringUtil.shorten(firstAssetRenderer.getSummary(locale), summaryLength));
		            	%>
		            	<div class="block_news_big">
			                <a href="<%=firstViewContentURL%>">
			                    <img alt="" src="<%=firstSmallImage %>">
			                </a>
		                </div>
		                
		                <div class="title_news title-panel">
		                    <a href="<%=firstViewContentURL%>"><%=firstTitle %></a>
		                </div>
		                
		                <c:if test="<%= showSummary %>">
			                <div class="news_lead summary-panel">
			                	<span><%= firstSummary %></span>
			                </div>
		                </c:if>
	                </c:if>
	            </c:if>
			</div>
        </div>
        <div class="nf3-right-content">
        	<div class="box_sub_hot_news">
	            <ul>
	                <%
	                for(AssetEntry assetEntry : results){
	                	long classPK = assetEntry.getClassPK();
	                	
	                	AssetRenderer assetRenderer = assetEntry.getAssetRenderer();
	                	
	            		if ((assetRenderer == null) || !assetRenderer.isDisplayable()) {
	            			continue;
	            		}
	                    
	                    String title = HtmlUtil.escape(StringUtil.shorten(assetRenderer.getTitle(locale), titleLength));
	                    
	                    String smallImage = NewsPublisherUtil.getSmallImagePath(request, classPK);
	            		
	            		if(Validator.isNull(smallImage) && useImageDefault){
	            			smallImage = assetRenderer.getThumbnailPath(renderRequest);
	            		}
	                    
	                    String viewContentURL = NewsPublisherUtil.getViewContentURL(request, assetEntry, linkedLayout);
	                    String summary = HtmlUtil.escape(StringUtil.shorten(assetRenderer.getSummary(locale), summaryLength));
	                    %>
	                        <li>
	                        	<div class="title_news">
	                            	<a href="<%=viewContentURL%>" title="<%=title %>"><%=title %></a>
	                            </div>
	                            <div class="bigImageTemp" style="display: none;" data-src="<%=smallImage %>"></div>
	                            
	                            <c:if test="<%= showSummary %>">
	                            	<div class="leadNewsTemp" style="display: none;" data-summary="<%=summary %>"></div>
	                            </c:if>
	                        </li>
	                    <%
	                }
	                %>
	            </ul>
	            
	            <c:if test="<%= showMore %>">
					<a class="icon-detail" title='<liferay-ui:message key="show-all"/>' href="<%= linkedLayoutURL %>">
						<liferay-ui:message key="show-all"/>
					</a>
				</c:if>
            </div>
        </div>
    </div>
</div>
<aui:script>
    AUI().ready(function(A){
       
        var listLi = A.all('.nf3-right-content ul li');
        var count = 0;
        
        listLi.each(function(node, index){
        	node.on('mouseover', function(){
        		<portlet:namespace/>changeFocusNews(node);
        	});
        });
        
        setInterval(function () {
            var li = null;
            listLi.each(function(node, index){
                if(index == count){
                    li = node;
                }
            });
            <portlet:namespace/>changeFocusNews(li);
            count++;
            if(count == listLi._nodes.length){
               count = 0;
            }
        }, 8000);
        
        

    });

    Liferay.provide(window,
        '<portlet:namespace/>changeFocusNews', function(li) {
            var A = AUI();
            var bigImg = A.one('#<portlet:namespace/>newsfocus3 .box_hot_news .block_news_big img');
            var titleNews = A.one('#<portlet:namespace/>newsfocus3 .box_hot_news .title_news');
            var leadNews = A.one('#<portlet:namespace/>newsfocus3 .box_hot_news .news_lead');
            
			if(li){
                if(li.one('.leadNewsTemp') && leadNews) {
                	var leadNewsTemp = li.one('.leadNewsTemp').getAttribute('data-summary');
                	leadNews.set('innerHTML', leadNewsTemp);
                }

                if(li.one('.bigImageTemp') && bigImg) {
                	var bigImageTemp = li.one('.bigImageTemp').getAttribute('data-src');
                	bigImg.attr('src', bigImageTemp);
                }
                
                if(li.one('.title_news') && titleNews) {
                	var titleNewsTemp = li.one('.title_news').get('innerHTML');
                	titleNews.set('innerHTML', titleNewsTemp);
                }
            }
        }
    );

</aui:script>