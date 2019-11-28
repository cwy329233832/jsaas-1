<%-- 
    Document   : [KdDocContr]编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="rx" uri="http://www.redxun.cn/formFun"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>[KdDocContr]编辑</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<%@include file="/commons/dynamic.jspf"%>
<script src="${ctxPath}/scripts/boot.js" type="text/javascript"></script>
<script src="${ctxPath}/scripts/share.js" type="text/javascript"></script>
<link href="${ctxPath}/styles/icons.css" rel="stylesheet" type="text/css" />
<link href="${ctxPath}/styles/form.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="${kdDocContr.contId}" />
	<div id="p1" class="form-outer">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="contId" class="mini-hidden" value="${kdDocContr.contId}" />
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<caption>[KdDocContr]基本信息</caption>

					<tr>
						<th>词条 ：</th>
						<td><input name="docId" value="${kdDocContr.docId}" class="mini-textbox" vtype="maxLength:64" style="width: 90%" /></td>
					</tr>

					<tr>
						<th>修改原因分类 <span class="star">*</span> ：
						</th>
						<td><input name="modType" value="${kdDocContr.modType}" class="mini-textbox" vtype="maxLength:50" style="width: 90%" required="true" emptyText="请输入更正错误" /></td>
					</tr>

					<tr>
						<th>修改原因：</th>
						<td><textarea name="reason" class="mini-textarea" vtype="maxLength:500" style="width: 90%">${kdDocContr.reason}</textarea></td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="kms/core/kdDocContr" entityName="com.redxun.kms.core.entity.KdDocContr" />
</body>
</html>