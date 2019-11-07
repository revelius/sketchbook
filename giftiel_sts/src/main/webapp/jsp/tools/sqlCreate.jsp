<%@ page contentType="text/html; charset=utf-8" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<!DOCTYPE html>
<html lang="ko">

<head>
	<jsp:include page="/jsp/tools/include/head.jsp" flush="true"/>
	<script type="text/javascript">
	function nameChange(val){
		$("[id='domainName']").html(val);
		$("[id='domainName2']").html(val.substring(0,1).toUpperCase()+""+val.substring(1,getTextLength(val)));
	}
	
	function nameChange2(val){
		$("[id='domainName3']").html(val.toUpperCase()+".");
		$("[id='domainName4']").html(val.toUpperCase());
	}	
	
    function getTextLength(str) {
        var len = 0;
        for (var i = 0; i < str.length; i++) {
            if (escape(str.charAt(i)).length == 6) {
                len++;
            }
            len++;
        }
        return len;
    }	
	</script>
</head>

<body>
	<jsp:include page="/jsp/tools/include/leftMenu.jsp" flush="true"/>
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">테이블 리스트</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
	  		<c:forEach items="${fn:split(tableName,'_')}" var="tableNames" varStatus="listCount3" begin="2">
				<c:set var="tableNames2" value="${tableNames2}${fn:toUpperCase(fn:substring(tableNames,0,1))}${fn:toLowerCase(fn:substring(tableNames,1,20))}"/>													
	  		</c:forEach>            
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            source create ${tableName }
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="dataTable_wrapper">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>
                                            	ResultMap(MODEL)
                                            	<input type="text" id="domain" class="form-control" onkeyup="nameChange(this.value);">
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
							            <tr class="odd gradeX">
							            	<td>
							            		<font color="#3f7f5f">&lt;resultMap</font> <font color="#7f0055">id</font>=<font color="#0000c0">"list<c:out value="${fn:replace(tableNames2,' ','') }"/>"</font> <font color="#7f0055">type</font>=<font color="#0000c0">"com.giftiel.shop.dto.<span id="domainName2"></span>"</font><font color="#3f7f5f">&gt;</font><br/>
							            		&nbsp; &nbsp; <font color="#3f7f5f">&lt;result</font> <font color="#7f0055">property</font>=<font color="#0000c0">"rnum"</font> <font color="#7f0055">column</font>=<font color="#0000c0">"RNUM"</font><font color="#3f7f5f">/&gt;</font><br/> 
								            	<c:forEach items="${selectColumnList}" var="table" varStatus="listCount">
													<c:set var="columnName" value=""/>
													<c:forEach items="${fn:split(table.columnName,'_')}" var="columnNames" varStatus="listCount2">
														<c:choose>
															<c:when test="${listCount2.first }">
																<c:set var="columnName" value="${columnName}${fn:toLowerCase(fn:substring(columnNames,0,1))}${fn:toLowerCase(fn:substring(columnNames,1,20))}"/>													
															</c:when>
															<c:otherwise>
																<c:set var="columnName" value="${columnName}${fn:toUpperCase(fn:substring(columnNames,0,1))}${fn:toLowerCase(fn:substring(columnNames,1,20))}"/>													
															</c:otherwise>
														</c:choose>													
													</c:forEach>
									            	&nbsp; &nbsp; <font color="#3f7f5f">&lt;result</font> <font color="#7f0055">property</font>=<font color="#0000c0">"<c:out value="${fn:replace(columnName,' ','') }"/>"</font> <font color="#7f0055">column</font>=<font color="#0000c0">"${table.columnName }"</font><font color="#3f7f5f">/&gt;</font>
													<br/>
								            	</c:forEach>  
												<font color="#3f7f5f">&lt;/resultMap&gt;</font>
							            	</td>
							            </tr>
                                    </tbody>
                                </table>
                            </div>
                            
                            <div class="dataTable_wrapper">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>
                                            LIST PAGING
                                            <input type="text" id="domain2" class="form-control" onkeyup="nameChange2(this.value);">
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
							            <tr class="odd gradeX">
							            	<td>
							            		<font color="#3f7f5f">&lt;select</font> <font color="#7f0055">id</font>=<font color="#0000c0">"list<c:out value="${fn:replace(tableNames2,' ','') }"/>"</font> <font color="#7f0055">parameterType</font>=<font color="#0000c0">"com.giftiel.shop.dto.<span id="domainName2"></span>"</font><font color="#7f0055"> resultMap</font>=<font color="#0000c0">"list<c:out value="${fn:replace(tableNames2,' ','') }"/>"</font><font color="#3f7f5f">&gt;</font><br/>
							            		SELECT<br/>
							            		&nbsp; &nbsp; RNUM<br/>
								            	<c:forEach items="${selectColumnList}" var="table" varStatus="listCount">
													&nbsp; &nbsp; ,<span id="domainName3"></span>${table.columnName } <br/>
								            	</c:forEach>
								            	FROM(<br/>
							            		&nbsp; &nbsp; SELECT <br/>
							            		&nbsp; &nbsp; &nbsp; &nbsp; ROWNUM RNUM<br/>
								            	<c:forEach items="${selectColumnList}" var="table" varStatus="listCount">
													&nbsp; &nbsp; &nbsp; &nbsp; ,<span id="domainName3"></span>${table.columnName } <br/>
								            	</c:forEach>  
								            	&nbsp; &nbsp; FROM<br/>
								            	&nbsp; &nbsp; &nbsp; &nbsp; ${tableName } <span id="domainName4"></span><br/> 
								            	&nbsp; &nbsp; WHERE  1 = 1<br/>
								            	<c:forEach items="${selectColumnList}" var="table" varStatus="listCount">
													<c:set var="columnName" value=""/>
													<c:forEach items="${fn:split(table.columnName,'_')}" var="columnNames" varStatus="listCount2">
														<c:choose>
															<c:when test="${listCount2.first }">
																<c:set var="columnName" value="${columnName}${fn:toLowerCase(fn:substring(columnNames,0,1))}${fn:toLowerCase(fn:substring(columnNames,1,20))}"/>													
															</c:when>
															<c:otherwise>
																<c:set var="columnName" value="${columnName}${fn:toUpperCase(fn:substring(columnNames,0,1))}${fn:toLowerCase(fn:substring(columnNames,1,20))}"/>													
															</c:otherwise>
														</c:choose>													
													</c:forEach>
													&nbsp; &nbsp; <font color="#3f7f5f">&lt;if</font> <font color="#7f0055">test</font>=<font color="#0000c0">"<c:out value="${fn:replace(columnName,' ','') }"/> != null and <c:out value="${fn:replace(columnName,' ','') }"/> != ''"</font><font color="#3f7f5f">&gt;</font> <br/>
													&nbsp; &nbsp; &nbsp; &nbsp; AND <span id="domainName3"></span>${table.columnName } = #&#123;<c:out value="${fn:replace(columnName,' ','') }"/>&#125;<br/>
													&nbsp; &nbsp; <font color="#3f7f5f">&lt;/if&gt;</font><br/>
								            	</c:forEach>
								            	) WHERE 1=1<br/>
								            	&nbsp; &nbsp; AND ROWNUM BETWEEN #&#123;startListNum&#125; AND #&#123;endListNum&#125;<br/>
												<font color="#3f7f5f">&lt;/select&gt;</font>
												
												<br/><br/><br/><br/>
												
												<font color="#3f7f5f">&lt;select</font> <font color="#7f0055">id</font>=<font color="#0000c0">"totalList<c:out value="${fn:replace(tableNames2,' ','') }"/>"</font> <font color="#7f0055">parameterType</font>=<font color="#0000c0">"com.giftiel.shop.dto.<span id="domainName2"></span>"</font><font color="#7f0055"> resultMap</font>=<font color="#0000c0">"list<c:out value="${fn:replace(tableNames2,' ','') }"/>"</font><font color="#3f7f5f">&gt;</font><br/>
							            		&nbsp; &nbsp; SELECT <br/>
							            		&nbsp; &nbsp; &nbsp; &nbsp; COUNT(*) TOTAL_CNT <br/>
								            	&nbsp; &nbsp; FROM<br/>
								            	&nbsp; &nbsp; &nbsp; &nbsp; ${tableName } <span id="domainName4"></span><br/> 
								            	&nbsp; &nbsp; WHERE  1 = 1<br/>
								            	<c:forEach items="${selectColumnList}" var="table" varStatus="listCount">
													<c:set var="columnName" value=""/>
													<c:forEach items="${fn:split(table.columnName,'_')}" var="columnNames" varStatus="listCount2">
														<c:choose>
															<c:when test="${listCount2.first }">
																<c:set var="columnName" value="${columnName}${fn:toLowerCase(fn:substring(columnNames,0,1))}${fn:toLowerCase(fn:substring(columnNames,1,20))}"/>													
															</c:when>
															<c:otherwise>
																<c:set var="columnName" value="${columnName}${fn:toUpperCase(fn:substring(columnNames,0,1))}${fn:toLowerCase(fn:substring(columnNames,1,20))}"/>													
															</c:otherwise>
														</c:choose>													
													</c:forEach>
													&nbsp; &nbsp; <font color="#3f7f5f">&lt;if</font> <font color="#7f0055">test</font>=<font color="#0000c0">"<c:out value="${fn:replace(columnName,' ','') }"/> != null"</font><font color="#3f7f5f">&gt;</font> <br/>
													&nbsp; &nbsp; &nbsp; &nbsp; AND <span id="domainName3"></span>${table.columnName } = #&#123;<c:out value="${fn:replace(columnName,' ','') }"/>&#125;<br/>
													&nbsp; &nbsp; <font color="#3f7f5f">&lt;/if&gt;</font><br/>
								            	</c:forEach>
												<font color="#3f7f5f">&lt;/select&gt;</font>												
							            	</td>
							            </tr>
                                    </tbody>
                                </table>
                            </div>                   
                            
                            <div class="dataTable_wrapper">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>
                                            INSERT
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
							            <tr class="odd gradeX">
							            	<td>
							            		<font color="#3f7f5f">&lt;insert</font> <font color="#7f0055">id</font>=<font color="#0000c0">"insert<c:out value="${fn:replace(tableNames2,' ','') }"/>"</font> <font color="#7f0055">parameterType</font>=<font color="#0000c0">"com.giftiel.shop.dto.<span id="domainName2"></span>"</font><font color="#3f7f5f">&gt;</font><br/>
							            		&nbsp; &nbsp; INSERT INTO ${tableName }<br/>
							            		&nbsp; &nbsp; &nbsp; &nbsp; (
								            	<c:forEach items="${selectColumnList}" var="table" varStatus="listCount">
								            		${table.columnName }
													<c:choose>
														<c:when test="${listCount.last }">
														</c:when>
														<c:otherwise>
														,
														</c:otherwise>
													</c:choose>
								            	</c:forEach>
								            	)<br/>
								 				&nbsp; &nbsp; VALUES
								 				<br/>
								 				&nbsp; &nbsp; &nbsp; &nbsp; (
									            	<c:forEach items="${selectColumnList}" var="table" varStatus="listCount">
														<c:set var="columnName" value=""/>
														<c:forEach items="${fn:split(table.columnName,'_')}" var="columnNames" varStatus="listCount2">
															<c:choose>
																<c:when test="${listCount2.first }">
																	<c:set var="columnName" value="${columnName}${fn:toLowerCase(fn:substring(columnNames,0,1))}${fn:toLowerCase(fn:substring(columnNames,1,20))}"/>													
																</c:when>
																<c:otherwise>
																	<c:set var="columnName" value="${columnName}${fn:toUpperCase(fn:substring(columnNames,0,1))}${fn:toLowerCase(fn:substring(columnNames,1,20))}"/>													
																</c:otherwise>
															</c:choose>													
														</c:forEach>
															<c:choose>
																<c:when test="${fn:replace(columnName,' ','')=='regDts' }">
																	SYSDATE
																</c:when>
																<c:when test="${fn:replace(columnName,' ','')=='updDts' }">
																	SYSDATE
																</c:when>
																<c:otherwise>
																	#&#123;<c:out value="${fn:replace(columnName,' ','') }"/>&#125;
																</c:otherwise>
															</c:choose>															
														<c:choose>
															<c:when test="${listCount.last }">
															</c:when>
															<c:otherwise>
															,
															</c:otherwise>
														</c:choose>
									            	</c:forEach>
								 				)<br/>
												<font color="#3f7f5f">&lt;/insert&gt;</font>
							            	</td>
							            </tr>
                                    </tbody>
                                </table>
                            </div>  
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="/resources/tools/bower_components/jquery/dist/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="/resources/tools/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="/resources/tools/bower_components/metisMenu/dist/metisMenu.min.js"></script>

    <!-- DataTables JavaScript -->
    <script src="/resources/tools/bower_components/DataTables/media/js/jquery.dataTables.min.js"></script>
    <script src="/resources/tools/bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="/resources/tools/dist/js/sb-admin-2.js"></script>

    <!-- Page-Level Demo Scripts - Tables - Use for reference -->
    <script>
    $(document).ready(function() {
        $('#dataTables-example').DataTable({
                responsive: true
        });
    });
    </script>

</body>

</html>
