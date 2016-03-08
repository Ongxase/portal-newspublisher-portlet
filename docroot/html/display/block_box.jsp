
<%@ include file="/init.jsp" %>

<%
	String style = StringPool.BLANK;

	String[] indexs = StringUtil.split(blockIndex);
	
	if(indexs != null && indexs.length > 0){
		%>
		<div class="k1">
		<%
		int countItem = 0;
		for(String index:indexs){
			
			if(Validator.isNumber(index)){
				
				countItem ++;
				
				String[] tagNameValuesBlock = portletPreferences.getValues("tagNameValues" + index, new String[0]);
				
				String[] categoryIdValuesBlock = portletPreferences.getValues("categoryIdValues" +  index, new String[0]);
			
				String blockTitle = HtmlUtil.escape(portletPreferences.getValue("blockTitle" + index, StringPool.BLANK));
				
				boolean tagQueryContainsBlock = true;
				boolean tagQueryAndOperatorBlock = false;
				boolean categoryQueryContainsBlock = true;
				boolean categoryQueryAndOperatorBlock = false;
				
				NewsPublisherUtil.setAssetEntryQuery(assetEntryQuery, arrGroupIds, tagNameValuesBlock, 
					categoryIdValuesBlock, tagQueryContainsBlock, tagQueryAndOperatorBlock, categoryQueryContainsBlock, 
					categoryQueryAndOperatorBlock);
				
				List<AssetEntry> assetEntries = NewsPublisherUtil.getAssetEntries(assetEntryQuery);
				
				String css = StringPool.BLANK;
				
				String layoutUuidIndex = portletPreferences.getValue("layoutUuid" + index, StringPool.BLANK);
				
				Layout blockLayout = themeDisplay.getLayout();
				
				String blockLayoutURL = StringPool.BLANK;
				
				if(Validator.isNotNull(layoutUuidIndex)){
					blockLayout = LayoutLocalServiceUtil.fetchLayoutByUuidAndGroupId(layoutUuidIndex, themeDisplay.getScopeGroupId(), false);
				}
				
				if(blockLayout != null){
					blockLayoutURL = PortalUtil.getLayoutFullURL(blockLayout, themeDisplay);
				}
				
				if(indexs.length > 1){
					if(countItem % 2 == 0){
						css = "folderleft";
					}else{
						css = "folderright";
					}
				}
				
				%>
					<div class="<%= css %>">
						<h3 class="tlecmh3">
							<a class="hdCM" href="<%=blockLayoutURL%>"><i class="tlecm"></i><%=blockTitle %></a>
						</h3>
						<ul class="box_tp bgxam">
							<%
								if(assetEntries != null){
									int count = 0;
									for(AssetEntry assetEntry:assetEntries){
										count ++;
										
										try {
											AssetRenderer assetRenderer = assetEntry.getAssetRenderer();
										
										
										String title = StringUtil.shorten(assetRenderer.getTitle(locale), titleLength);
										
										String smallImagePath = NewsPublisherUtil.getSmallImagePath(request, assetEntry.getClassPK());
										
										if(Validator.isNull(smallImagePath) && useImageDefault){
											smallImagePath = assetRenderer.getThumbnailPath(renderRequest);
										}
										
										String viewContentURL = NewsPublisherUtil.getViewContentURL(request, assetEntry, blockLayout);
										
										if(count == 1){
											String summary = StringUtil.shorten(assetRenderer.getSummary(locale), summaryLength);
											summary = HtmlUtil.escape(summary);
											%>
												<li class="lifirst bo">
													<p><a class="tieudetin" href="<%=viewContentURL%>"><%=title %></a></p>
													<p class="first">
														<c:choose>
															<c:when test="<%= Validator.isNotNull(smallImagePath) %>">
																<a href="<%=viewContentURL%>">
																	<img src="<%=smallImagePath%>" alt="">
																</a>
																
																<%=summary %>
															</c:when>
															
															<c:otherwise>
																<%=summary %>
															</c:otherwise>
														</c:choose>
													</p>
												</li>
											<%
										}else{
											%>
												<li class="tin_tiep nobo">
													<a href="<%=viewContentURL%>">
														<%=title %>
													</a>
												</li>
											<%
										}
										
										} catch (Exception e) {
										}
										
									}
								}
							%>
						</ul>

					</div>
				<%
			}
		}
		%>
		
		</div>
		<%
	}
	
%>
