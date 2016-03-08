
<%@ include file="/init.jsp" %>

<%
	SearchContainer searchContainer = (SearchContainer)request.getAttribute("view.jsp-searchContainer");
	
	List<AssetEntry> assetEntries = (List<AssetEntry>)searchContainer.getResults();
	
	StringBuilder newsItems = new StringBuilder();
	if(assetEntries != null && !assetEntries.isEmpty()){
		%>
			<div class="tin_anh">
				<div class="bg_tina">
					<div id="featured">
					
						<ul class="ui-tabs-nav">
							<%
							int count = 0;
							for(AssetEntry assetEntry:assetEntries){
								AssetRenderer assetRenderer = assetEntry.getAssetRenderer();
								String title = assetRenderer.getTitle(locale);
								title = StringUtil.shorten(title, titleLength);
								
								String smallImagePath = NewsPublisherUtil.getSmallImagePath(request, assetEntry.getClassPK());
								if(Validator.isNull(smallImagePath)){
									smallImagePath = assetRenderer.getThumbnailPath(renderRequest);
								}
								
								String summary = assetRenderer.getSummary(locale);
								summary = StringUtil.shorten(summary, summaryLength);
								
								String viewContentURL = NewsPublisherUtil.getViewContentURL(request, assetEntry, linkedLayout);
								
								newsItems.append("<div id=\"fragment-").append(count).append("\"").append(" class=\"ui-tabs-panel");
								if(count > 0){
									newsItems.append(" ui-tabs-hide\"");
								}else{
									newsItems.append("\"");
								}
								newsItems.append(" style=\"\"/>");
								newsItems.append("<img src=\"").append(smallImagePath).append("\"").append(" alt=\"").append(title).append("\"/>");
								newsItems.append("<div class=\"info\" >");
								newsItems.append("<h2><a href=\"").append(viewContentURL).append("\">").append(title).append("</a></h2>");
								newsItems.append("<p>").append(summary).append("<a href=\"");
								newsItems.append(viewContentURL).append("\">").append("</a></p></div></div>");
								String liSelected = StringPool.BLANK;
								if(count == 0){
									liSelected = "ui-tabs-selected";
								}
								%>
									<li class='<%="ui-tabs-nav-item " + liSelected %>' id='<%="nav-fragment-" + count%>'>
										<a href='<%="#fragment-" + count%>'><img  alt="<%=title %>" src="<%=smallImagePath%>" /></a>
									</li>
								<%
								count ++;
							}
							%>
						</ul>
						<%=newsItems.toString() %>
					</div>
					
				</div>
			</div>
		<%
	}
%>
<script type="text/javascript">
	jQuery(document).ready(function(){
		jQuery("#featured > ul").tabs({fx:{opacity: "toggle"}}).tabs("rotate", 5000, true);
		var containerWidth = jQuery('#featured').width();
		var tabWidth = jQuery('.ui-tabs-nav').first().width();
		var focusNewsWidth = containerWidth - tabWidth - 7;
		var focusNews = jQuery('.ui-tabs-panel');
		focusNews.each(function(index, node){
			jQuery(node).css('width',focusNewsWidth + 'px');
		});
	});
</script>
