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
                                            	Domain(MODEL)
                                            	<input type="text" id="domain" class="form-control" onkeyup="nameChange(this.value);">
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
							            <tr class="odd gradeX">
							            	<td>
							            		<font color="#7f0055" style="font-weight:bold">private</font> Integer <font color="#0000c0">rnum;</font><font color="#3f7f5f">&nbsp; &nbsp; &nbsp; &nbsp; //번호</font><br/>
							            		<font color="#7f0055" style="font-weight:bold">private</font> Integer <font color="#0000c0">totalCnt;</font><font color="#3f7f5f">&nbsp; &nbsp; &nbsp; &nbsp; //총 갯수</font><br/>
							            		<font color="#7f0055" style="font-weight:bold">private</font> Integer <font color="#0000c0">startListNum;</font><font color="#3f7f5f">&nbsp; &nbsp; &nbsp; &nbsp; //페이징 시작번호</font><br/>
							            		<font color="#7f0055" style="font-weight:bold">private</font> Integer <font color="#0000c0">endListNum;</font><font color="#3f7f5f">&nbsp; &nbsp; &nbsp; &nbsp; //페이징 끝번호</font><br/>
								            	<c:forEach items="${selectColumnList}" var="table" varStatus="listCount">
									            	<font color="#7f0055" style="font-weight:bold">private</font>
													<c:choose>
														<c:when test="${table.dataType=='CHAR'}">String</c:when>
														<c:when test="${table.dataType=='VARCAHR2'}">String</c:when>
														<c:when test="${table.dataType=='DATE'}">Date</c:when>
														<c:when test="${table.dataType=='TIMESTAMP(6)'}">Date</c:when>
														<c:when test="${table.dataType=='NUMBER'}">Integer</c:when>
														
														<c:otherwise>String</c:otherwise>
													</c:choose>
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
													<font color="#0000c0"><c:out value="${fn:replace(columnName,' ','') }"/>;</font>
													<font color="#3f7f5f">&nbsp; &nbsp; &nbsp; &nbsp; //${table.comments }</font>
									            	<br/>
								            	</c:forEach>  
							            	</td>
							            </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="dataTable_wrapper">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>DAO</th>
                                        </tr>
                                    </thead>
                                    <tbody>
							            <tr class="odd gradeX">
							            	<td>
							            		<c:set var="tableNames2" value=""/>
							            		<c:forEach items="${fn:split(tableName,'_')}" var="tableNames" varStatus="listCount3" begin="2">
													<c:set var="tableNames2" value="${tableNames2}${fn:toUpperCase(fn:substring(tableNames,0,1))}${fn:toLowerCase(fn:substring(tableNames,1,20))}"/>													
							            		</c:forEach>
												<font color="#7f0055" style="font-weight:bold">public</font> List&lt;<span id="domainName2"></span>&gt; list<c:out value="${fn:replace(tableNames2,' ','') }"/>(SearchForm searchForm) {<br/>
												&nbsp; &nbsp; List&lt;<span id="domainName2"></span>&gt; result = <font color="#0000c0">sqlSession</font>.selectList(<font color="#0000c0">"<span id="domainName"></span>.list<c:out value="${fn:replace(tableNames2,' ','') }"/>"</font>, searchForm);<br/>
												&nbsp; &nbsp; <font color="#7f0055" style="font-weight:bold">return</font> result;<br/>
												}<br/>
												
												<font color="#7f0055" style="font-weight:bold">public</font> int totalList<c:out value="${fn:replace(tableNames2,' ','') }"/>(SearchForm searchForm) {<br/>
												&nbsp; &nbsp; int result = <font color="#0000c0">sqlSession</font>.insert(<font color="#0000c0">"<span id="domainName"></span>.totalList<c:out value="${fn:replace(tableNames2,' ','') }"/>"</font>, searchForm);<br/>
												&nbsp; &nbsp; <font color="#7f0055" style="font-weight:bold">return</font> result;<br/>
												}<br/>												
												
												<font color="#7f0055" style="font-weight:bold">public</font> <span id="domainName2"></span> select<c:out value="${fn:replace(tableNames2,' ','') }"/>(SearchForm searchForm) {<br/>
												&nbsp; &nbsp; <span id="domainName2"></span> result = <font color="#0000c0">sqlSession</font>.selectOne(<font color="#0000c0">"<span id="domainName"></span>.select<c:out value="${fn:replace(tableNames2,' ','') }"/>"</font>, searchForm);<br/>
												&nbsp; &nbsp; <font color="#7f0055" style="font-weight:bold">return</font> result;<br/>
												}<br/>
												
												<font color="#7f0055" style="font-weight:bold">public</font> int insert<c:out value="${fn:replace(tableNames2,' ','') }"/>(SearchForm searchForm) {<br/>
												&nbsp; &nbsp; int result = <font color="#0000c0">sqlSession</font>.insert(<font color="#0000c0">"<span id="domainName"></span>.insert<c:out value="${fn:replace(tableNames2,' ','') }"/>"</font>, searchForm);<br/>
												&nbsp; &nbsp; <font color="#7f0055" style="font-weight:bold">return</font> result;<br/>
												}<br/>
																								
												<font color="#7f0055" style="font-weight:bold">public</font> int update<c:out value="${fn:replace(tableNames2,' ','') }"/>(SearchForm searchForm) {<br/>
												&nbsp; &nbsp; int result = <font color="#0000c0">sqlSession</font>.update(<font color="#0000c0">"<span id="domainName"></span>.update<c:out value="${fn:replace(tableNames2,' ','') }"/>"</font>, searchForm);<br/>
												&nbsp; &nbsp; <font color="#7f0055" style="font-weight:bold">return</font> result;<br/>
												}<br/>
												
												<font color="#7f0055" style="font-weight:bold">public</font> int delete<c:out value="${fn:replace(tableNames2,' ','') }"/>(SearchForm searchForm) {<br/>
												&nbsp; &nbsp; int result = <font color="#0000c0">sqlSession</font>.delete(<font color="#0000c0">"<span id="domainName"></span>.delete<c:out value="${fn:replace(tableNames2,' ','') }"/>"</font>, searchForm);<br/>
												&nbsp; &nbsp; <font color="#7f0055" style="font-weight:bold">return</font> result;<br/>
												}<br/>
							            	</td>
							            </tr>
                                    </tbody>
                                </table>
                            </div>            
                            
                            <div class="dataTable_wrapper">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>getRequest</th>
                                        </tr>
                                    </thead>
                                    <tbody>
							            <tr class="odd gradeX">
							            	<td>
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
													reqeust.getParameter("<font color="#0000c0"><c:out value="${fn:replace(columnName,' ','') }"/></font>");
													<font color="#3f7f5f">&nbsp; &nbsp; &nbsp; &nbsp; //${table.comments }</font>
									            	<br/>
								            	</c:forEach> 
							            	</td>
							            </tr>
                                    </tbody>
                                </table>
                            </div> 
                            
                            <div class="dataTable_wrapper">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>getRequest setter ,getter</th>
                                        </tr>
                                    </thead>
                                    <tbody>
							            <tr class="odd gradeX">
							            	<td>
								            	<c:forEach items="${selectColumnList}" var="table" varStatus="listCount">
													<c:set var="columnName" value=""/>
													<c:set var="columnName2" value=""/>
													<c:forEach items="${fn:split(table.columnName,'_')}" var="columnNames" varStatus="listCount2">
														<c:choose>
															<c:when test="${listCount2.first }">
																<c:set var="columnName" value="${columnName}${fn:toLowerCase(fn:substring(columnNames,0,1))}${fn:toLowerCase(fn:substring(columnNames,1,20))}"/>													
															</c:when>
															<c:otherwise>
																<c:set var="columnName" value="${columnName}${fn:toUpperCase(fn:substring(columnNames,0,1))}${fn:toLowerCase(fn:substring(columnNames,1,20))}"/>													
															</c:otherwise>
														</c:choose>			
														<c:set var="columnName2" value="${columnName2}${fn:toUpperCase(fn:substring(columnNames,0,1))}${fn:toLowerCase(fn:substring(columnNames,1,20))}"/>										
													</c:forEach>
													<span id="domainName"></span>.set<c:out value="${fn:replace(columnName2,' ','') }"/>(<font color="#0000c0">""</font>);
													<font color="#3f7f5f">&nbsp; &nbsp; &nbsp; &nbsp; //${table.comments }</font>
									            	<br/>
								            	</c:forEach> 
								            	<br/>
								            	<c:forEach items="${selectColumnList}" var="table" varStatus="listCount">
													<c:set var="columnName" value=""/>
													<c:set var="columnName2" value=""/>
													<c:forEach items="${fn:split(table.columnName,'_')}" var="columnNames" varStatus="listCount2">
														<c:choose>
															<c:when test="${listCount2.first }">
																<c:set var="columnName" value="${columnName}${fn:toLowerCase(fn:substring(columnNames,0,1))}${fn:toLowerCase(fn:substring(columnNames,1,20))}"/>													
															</c:when>
															<c:otherwise>
																<c:set var="columnName" value="${columnName}${fn:toUpperCase(fn:substring(columnNames,0,1))}${fn:toLowerCase(fn:substring(columnNames,1,20))}"/>													
															</c:otherwise>
														</c:choose>			
														<c:set var="columnName2" value="${columnName2}${fn:toUpperCase(fn:substring(columnNames,0,1))}${fn:toLowerCase(fn:substring(columnNames,1,20))}"/>										
													</c:forEach>
													<span id="domainName"></span>.set<c:out value="${fn:replace(columnName2,' ','') }"/>(reqeust.getParameter("<font color="#0000c0"><c:out value="${fn:replace(columnName,' ','') }"/></font>"));
													<font color="#3f7f5f">&nbsp; &nbsp; &nbsp; &nbsp; //${table.comments }</font>
									            	<br/>
								            	</c:forEach> 
								            	<br/>
								            	<c:forEach items="${selectColumnList}" var="table" varStatus="listCount">
													<c:set var="columnName" value=""/>
													<c:set var="columnName2" value=""/>
													<c:forEach items="${fn:split(table.columnName,'_')}" var="columnNames" varStatus="listCount2">
														<c:choose>
															<c:when test="${listCount2.first }">
																<c:set var="columnName" value="${columnName}${fn:toLowerCase(fn:substring(columnNames,0,1))}${fn:toLowerCase(fn:substring(columnNames,1,20))}"/>													
															</c:when>
															<c:otherwise>
																<c:set var="columnName" value="${columnName}${fn:toUpperCase(fn:substring(columnNames,0,1))}${fn:toLowerCase(fn:substring(columnNames,1,20))}"/>													
															</c:otherwise>
														</c:choose>			
														<c:set var="columnName2" value="${columnName2}${fn:toUpperCase(fn:substring(columnNames,0,1))}${fn:toLowerCase(fn:substring(columnNames,1,20))}"/>										
													</c:forEach>
													<span id="domainName"></span>.get<c:out value="${fn:replace(columnName2,' ','') }"/>();
													<font color="#3f7f5f">&nbsp; &nbsp; &nbsp; &nbsp; //${table.comments }</font>
									            	<br/>
								            	</c:forEach>								            	
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
