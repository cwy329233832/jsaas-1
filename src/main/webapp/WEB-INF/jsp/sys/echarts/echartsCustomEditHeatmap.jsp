<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[自定义查询]编辑</title>
<%@include file="/commons/edit.jsp"%>
<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
<script src="${ctxPath}/scripts/codemirror/mode/groovy/groovy.js"></script>
<script src="${ctxPath}/scripts/codemirror/mode/sql/sql.js"></script>
<script src="${ctxPath}/scripts/codemirror/addon/edit/matchbrackets.js"></script>
<script src="${ctxPath}/scripts/share/dialog.js"></script>
<link href="${ctxPath}/scripts/sys/echarts/css/custom.css?version=${static_res_version}" rel="stylesheet" type="text/css" />

</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="echartsCustom.id" />
	<div class="form-container">
		
		<form id="form1" method="post">
			<input id="pkId" name="id" class="mini-hidden" value="${echartsCustom.id}" />
			<input id="table" name="table" class="mini-hidden" value="${echartsCustom.table}" />
			<input id="table" name="echartsType" class="mini-hidden" value="Heatmap" />

			<div id="tabs1" class="mini-tabs" activeIndex="0" plain="false" buttons="#tabsButtons">
				<div id="commonDetail" title="基础数据">
						<table class="table-detail column-two" cellspacing="1" cellpadding="0" style="margin-top: 0;">
							<tr>
								<td>图表名称</td>
								<td><input name="name" required="true" value="${echartsCustom.name}" class="mini-textbox" style="width:90%;"/></td>
							</tr>
							<tr>
								<td>标　　识</td>
								<td><input name="key" required="true" value="${echartsCustom.key}" class="mini-textbox" style="width:90%;"/></td>
							</tr>
							<tr>
								<td>数 据 源</td>
								<td><input name="dsAlias" value="${echartsCustom.dsAlias}" id="dsAlias" style="width: 350px;" text="${echartsCustom.dsAlias}"
									class="mini-buttonedit" showClose="true" onbuttonclick="onDatasource" oncloseclick="_ClearButtonEdit" /></td>
							</tr>
							<tr>
								<td>分类选择 *</td>
								<td>
									<input id="treeId" name="treeId" class="mini-treeselect" 
										   multiSelect="false" textField="name" valueField="treeId" parentField="parentId"  required="true" 
										   showFolderCheckBox="true"  expandOnLoad="true" showClose="true" oncloseclick="_ClearButtonEdit"
										   url="${ctxPath}/sys/echarts/echartsCustom/getUserGrantTreeList.do" resultAsTree="false"
										   popupWidth="350" style="width:350px"/>
								</td>
							</tr>
							<tr>
								<td>查询类型</td>
								<td>
									<div class="mini-radiobuttonlist" textField="text" valueField="id" 
										value='${(empty echartsCustom.sqlBuildType) ? 'freeMakerSql': echartsCustom.sqlBuildType}' 
										data="[{id:'freeMakerSql',text:'Freemarker Sql'}]" name="sqlBuildType" id="sqlBuildType"
										onvaluechanged="changeQueryType"></div>
								</td>
							</tr>
							<tr id="sqlTR">
								<td>输入SQL</td>
								<td style="padding: 4px 0 0 0 !important;">
									<div id="conditionDiv">
										支持freemaker语法 条件字段: <input id="freemarkColumn" class="mini-combobox" showNullItem="true" nullItemText="可选条件列头"
											valueField="fieldName" textField="fieldLabel" onvalueChanged="varsFreeChanged" /> 常量: <input id="constantItem"
											class="mini-combobox" showNullItem="true" nullItemText="可用常量" url="${ctxPath}/sys/core/public/getConstantItem.do"
											valueField="key" textField="val" onvalueChanged="constantFreeChanged" />
									</div><textarea id="sql" emptyText="请输入sql" rows="5" cols="100" width="500" style="height:50px;">${echartsCustom.sql}</textarea>
								</td>
							</tr>
							<tr>
								<td>主题设置</td>
								<td>
									<div style="height:auto;">
										<input id="legend-x" name="theme" class="mini-checkboxlist" multiSelect="false" 
										repeatItems="5" repeatLayout="table" 
										valueField="id" textField="text" 
										url="${ctxPath}/scripts/sys/echarts/theme.json"
										value="default"/>
									</div>
								</td>
							</tr>
						</table>
				</div>
				<div id="title-tab" title="标题设置">
						<table class="table-detail column-two" cellspacing="1" cellpadding="0" style="margin-top: 0;">
							<tr>
								<td>标题显示</td>
								<td><input id="title-show" class="mini-radiobuttonlist"
									valueField="id" textField="text" 
									data="[{'id':'0', 'text':'是'},{'id':'1', 'text':'否'}]" value="0"/></td>
							</tr>
							<tr>
								<td>标题对齐</td>
								<td>
									<table class="cell-table">
										<tr>
											<td><label class="cell-label">水平位置</label></td>
											<td><input id="title-x" class="mini-radiobuttonlist"
												valueField="id" textField="text" 
												data="[{'id':'left', 'text':'左'},{'id':'center', 'text':'中'},{'id':'right', 'text':'右'}]" value="left"/></td>
										</tr>
									</table>
									<table class="cell-table">
										<tr>
											<td><label class="cell-label">垂直位置</label></td>
											<td><input id="title-y" class="mini-radiobuttonlist"
												valueField="id" textField="text" 
												data="[{'id':'top', 'text':'上'},{'id':'middle', 'text':'中'},{'id':'bottom', 'text':'下'}]" value="top"/></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>字　　体</td>
								<td><input id="title-textStyle-fontFamily" class="mini-combobox" 
									style="width:150px;" textField="id" valueField="id" 
    								data="[{'id':'sans-serif'},{'id':'serif'},{'id':'monospace'},{'id':'Arial'},{'id':'Courier New'},{'id':'Microsoft YaHei'}]" 
    								value="sans-serif"/></td>
							</tr>
							<tr>
								<td>字体风格</td>
								<td><input id="title-textStyle-fontStyle" class="mini-combobox" 
									style="width:150px;" textField="text" valueField="id" 
    								data="[{'id':'normal', 'text':'正常'},{'id':'italic', 'text':'斜体'}]" value="normal"/></td>
							</tr>
							<tr>
								<td>字体大小</td>
								<td><input id="title-textStyle-fontSize" class="mini-textbox" vtype="int"
									style="width:150px;" textField="text" valueField="id" value="18"/></td>
							</tr>
							<tr>
								<td>副 标 题</td>
								<td><input id="title-subtext" value="" class="mini-textbox" style="width:50%;" maxlength="20"/></td>
							</tr>
						</table>
				</div>
				<div id="legend-tab" title="视觉映射">
						<table class="table-detail column-two" cellspacing="1" cellpadding="0" style="margin-top: 0;">
							<tr>
								<td>映射显示</td>
								<td><input id="legend-show" class="mini-radiobuttonlist"
									valueField="id" textField="text" 
									data="[{'id':'0', 'text':'是'},{'id':'1', 'text':'否'}]" value="1"/></td>
							</tr>
							<tr>
								<td>映射类型</td>
								<td><input id="legend-type" class="mini-radiobuttonlist"
									valueField="id" textField="text" 
									data="[{'id':'continuous', 'text':'连续型'},{'id':'piecewise', 'text':'分段型'}]" value="continuous"/></td>
							</tr>
							<tr>
								<td>映射对齐</td>
								<td>
									<table class="cell-table">
										<tr>
											<td><label class="cell-label">水平位置</label></td>
											<td><input id="legend-x" class="mini-radiobuttonlist"
												valueField="id" textField="text" 
												data="[{'id':'left', 'text':'左'},{'id':'center', 'text':'中'},{'id':'right', 'text':'右'}]" value="center"/></td>
										</tr>
									</table>
									<table class="cell-table">
										<tr>
											<td><label class="cell-label">垂直位置</label></td>
											<td><input id="legend-y" class="mini-radiobuttonlist"
												valueField="id" textField="text" 
												data="[{'id':'top', 'text':'上'},{'id':'middle', 'text':'中'},{'id':'bottom', 'text':'下'}]" value="top"/></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>布局朝向</td>
								<td><input id="legend-orient" class="mini-radiobuttonlist" valueField="id" textField="text" 
    								data="[{'id':'horizontal', 'text':'水平布局'},{'id':'vertical', 'text':'垂直布局'}]" 
    								value="horizontal"/></td>
							</tr>
							<tr>
								<td>拖拽手柄</td>
								<td><input id="legend-calculable" class="mini-radiobuttonlist"
									valueField="id" textField="text" 
									data="[{'id':'0', 'text':'是'},{'id':'1', 'text':'否'}]" value="0"/><span class="warning_p">映射类型为“连续型”时有效</span></td>
							</tr>
						</table>
				</div>
				<div title="数据字段" showCloseButton="false">
					<div class="form-toolBox" >
						<a class="mini-button"  plain="true" onclick="selectColumnQuery">列头设置</a>
						<a class="mini-button btn-red"
							 plain="true" onclick="removeRow('gridQuery')">删除</a>
						<span class="separator"></span> <a class="mini-button"
							 plain="true" onclick="upRow('gridQuery')">向上</a>
						<a class="mini-button"  plain="true"
							onclick="downRow('gridQuery')">向下</a>
					</div>

						<table class="table-detail column-four" cellspacing="1" cellpadding="0" style="margin-top: 0;">
							<tr>
								<td>行列转换</td>
								<td colspan="3"><input id="detailMethod-radar" name="detailMethod" class="mini-radiobuttonlist" valueField="id" textField="text" 
									data="[{'id':0, 'text':'否'}, {'id':1, 'text':'是'}]" 
									value="${not empty echartsCustom.detailMethod && echartsCustom.detailMethod == 0 ? 0 : 1}"/></td>
							</tr>
							<tr>
								<td>热力值</td>
								<td><input id="series-minRadius" class="mini-textbox" 
										style="width:60px;font-size:10px;" vtype="float"/>~
										<input id="series-maxRadius" class="mini-textbox" 
										style="width:60px;font-size:10px;" vtype="float"/>
									<p class="warning_p">&lowast;若不设置，请保留为空！</p>
								</td>
								<td>显示数值</td>
								<td><input id="series-labelShow" name="series-labelShow" class="mini-radiobuttonlist" valueField="id" textField="text" 
										data="[{'id':0, 'text':'否'}, {'id':1, 'text':'是'}]" value="0"/></td>
							</tr>
							<tr>
								<td>图形边距</td>
								<td colspan="3">
									<table class="cell-table">
										<tr>
											<td><label class="cell-label">上</label></td>
											<td><input id="grid-top" class="mini-textbox" 
												style="width:60px;font-size:10px;" textField="text" valueField="id" value="60" maxlength="4"/></td>
											<td><label class="cell-label">右</label></td>
											<td><input id="grid-right" class="mini-textbox" 
												style="width:60px;font-size:10px;" textField="text" valueField="id" value="10%" maxlength="4"/></td>
											<td><label class="cell-label">下</label></td>
											<td><input id="grid-bottom" class="mini-textbox" 
												style="width:60px;font-size:10px;" textField="text" valueField="id" value="60" maxlength="4"/></td>
											<td><label class="cell-label">左</label></td>
											<td><input id="grid-left" class="mini-textbox" 
												style="width:60px;font-size:10px;" textField="text" valueField="id" value="10%" maxlength="4"/></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>

					<div id="gridQuery" class="mini-datagrid" style="width: 100%;" showPager="false" allowCellEdit="true" allowCellSelect="true"
						allowAlternating="true">
						<div property="columns">
							<div type="indexcolumn">序号</div>
							<div field="comment" width="120" headerAlign="center">
								字段注解 <input property="editor" class="mini-textbox" />
							</div>
							<div field="fieldName" width="120" headerAlign="center">
								字段名 <input property="editor" class="mini-textbox" />
							</div>
						</div>
					</div>
				</div>
				<div title="图例字段" id="xAxis-tab" name="xAxis-tab" showCloseButton="false" visible="true">
					<div class="form-toolBox" >
						<a class="mini-button"  plain="true" onclick="selectColumnXAxis">列头设置</a>
						<a class="mini-button btn-red"  plain="true" onclick="removeRow('gridXAxis')">删除</a>
					</div>
					<div id="gridXAxis" class="mini-datagrid" style="width: 100%;" showPager="false" allowCellEdit="true" allowCellSelect="true"
						oncellbeginedit="gridWhereCellBeginEdit" oncellendedit="gridWhereCellEndEdit" allowAlternating="true">
						<div property="columns">
							<div type="indexcolumn" width="40">序号</div>
							<div field="comment" width="120" headerAlign="center">
								字段注解 <input property="editor" class="mini-textbox" />
							</div>
							<div field="fieldName" width="120" headerAlign="center">
								字段名 <input property="editor" class="mini-textbox" />
							</div>
						</div>
					</div>
				</div>
				<div title="条件的列" showCloseButton="false" visible="false">
					<div class="form-toolBox">
						<a class="mini-button"  plain="true"
							onclick="selectColumnWhere">列头设置</a> <a class="mini-button btn-red"
							 plain="true"
							onclick="removeRow('gridWhere')">删除</a> <span class="separator"></span>
						<a class="mini-button"  plain="true"
							onclick="upRow('gridWhere')">向上</a> <a class="mini-button"
							 plain="true" onclick="downRow('gridWhere')">向下</a>
					</div>
					<div id="gridWhere" class="mini-datagrid" style="width: 100%;"
						showPager="false" allowCellEdit="true" allowCellSelect="true"
						oncellbeginedit="gridWhereCellBeginEdit"
						oncellendedit="gridWhereCellEndEdit" allowAlternating="true">
						<div property="columns">
							<div type="indexcolumn" width="40">序号</div>
							<div field="comment" width="120" headerAlign="center">
								字段注解 <input property="editor" class="mini-textbox" />
							</div>
							<div field="fieldName" width="120" headerAlign="center">
								字段名 <input property="editor" class="mini-textbox" />
							</div>
							<div field="columnType" width="60" headerAlign="center">
								数据类型</div>
							<div name="typeOperate" displayField="typeOperate_name"
								valueField="id" textField="text" field="typeOperate"
								vtype="required" width="100" align="center" headerAlign="center">
								操作类型 <input property="editor" class="mini-combobox"
									valueField="id" textField="text" />
							</div>
							<div name="valueSource" field="valueSource" vtype="required"
								width="100" renderer="onvalueSourceRenderer" align="center"
								headerAlign="center" editor="valueSourceEditor">
								值来源 <input property="editor" class="mini-combobox"
									data="valueSource" />
							</div>
							<div name="valueDef" field="valueDef" width="180"
								headerAlign="center">默认值</div>
						</div>
					</div>
				</div>
				<div title="查询栏位" showCloseButton="false">
					<div class="form-toolBox">
						<a class="mini-button"  plain="true"
							onclick="selectColumnWhere">列头设置</a> <a class="mini-button btn-red"
							 plain="true"
							onclick="removeRow('gridWhere')">删除</a> <span class="separator"></span>
						<a class="mini-button"  plain="true"
							onclick="upRow('gridWhere')">向上</a> <a class="mini-button"
							 plain="true" onclick="downRow('gridWhere')">向下</a>
					</div>
					<div id="gridWhere" class="mini-datagrid" style="width: 100%;"
						showPager="false" allowCellEdit="true" allowCellSelect="true"
						oncellbeginedit="gridWhereCellBeginEdit"
						oncellendedit="gridWhereCellEndEdit" allowAlternating="true">
						<div property="columns">
							<div type="indexcolumn" width="40">序号</div>
							<div field="comment" width="80" headerAlign="center">
								字段注解 <input property="editor" class="mini-textbox" />
							</div>
							<div field="fieldName" width="80" headerAlign="center">
								字段名 <input property="editor" class="mini-textbox" />
							</div>
							<div field="valueSource" width="240" headerAlign="center">
								值来源(请输入SQL) <input property="editor" class="mini-textbox" />
							</div>
						</div>
					</div>
					<div id="divWhereJson" style="display: none;">${echartsCustom.whereField}</div>
				</div>
				<div title="下钻" showCloseButton="false">
						<table class="table-detail column-two" cellspacing="1" cellpadding="0" style="margin-top: 0;">
							<tr>
								<td>是否下钻</td>
								<td>
									<input id="openDrillDown" class="mini-radiobuttonlist"
										valueField="id" textField="text" 
										data="[{'id':'0', 'text':'否'},{'id':'1', 'text':'是'}]" value="0"/>
								</td>
							</tr>
						</table>
						<div id="openDrillDownDiv" style="display:none;">
							<table class="table-detail column-two" cellspacing="1" cellpadding="0" style="margin-top: 0;">
								<tr id="showDDKey">
									<td>下钻方式</td>
									<td>
										<input id="drillDownMethod" class="mini-radiobuttonlist"
											valueField="id" textField="text" 
											data="[{'id':'openWindow', 'text':'开窗'},{'id':'refreshSelf', 'text':'原图'}]" value="openWindow"/>
									</td>
								</tr>
								<tr id="openWindowMethod" style="display:none;">
									<td>开窗Url</td>
									<td>
										<a class="mini-button mini-button-primary" onclick="selectOpenWidowDemo('charts', this, 'window');">图形报表</a>
										<a class="mini-button mini-button-primary" onclick="selectOpenWidowDemo('customList', this, 'window');">自定义列表</a>
										<p style="margin:5px 0;">
											开窗key:<input id="openWindowKey" class="mini-textbox" allowInput="false" style="width:50%;"/>
										</p>
										<input id="openWindowUrl" class="mini-hidden" style="width:90%;"/>
									</td>
								</tr>
								<tr id="refreshSelfMethod" style="display:none;">
									<td>下钻key值</td>
									<td>
										<a class="mini-button mini-button-primary" onclick="selectOpenWidowDemo('charts', this, 'self');">图形报表</a>
										<p style="margin:5px 0;"><input id="drillDownKey" value="${echartsCustom.drillDownKey}" 
											class="mini-textbox" style="width:150px;margin-top:5px;" allowInput="false"/><br/>
											<span class="warning_p">* 原图下钻不支持表格</span></p>
									</td>
								</tr>
							</table>
						</div>

					<div class="form-toolBox" id="drillDownToolbar" style="display: none">
						<a class="mini-button"  plain="true"
							onclick="selectColumnDrillDown">列头设置</a>
						<a class="mini-button btn-red"  plain="true"
							onclick="removeRow('drillDown')">删除</a>
					</div>
					<div id="drillDown"
						 class="mini-datagrid"
						 visible="false"
						 style="width: 100%;"
						 showPager="false"
						 allowCellEdit="true"
						 allowCellSelect="true"
						 oncellbeginedit="gridWhereCellBeginEdit"
						 oncellendedit="gridWhereCellEndEdit"
						 allowAlternating="true"
					>
						<div property="columns">
							<div type="indexcolumn" width="40">序号</div>
							<div field="comment" width="80" headerAlign="center">
								字段注解 <input property="editor" class="mini-textbox" />
							</div>
							<div field="fieldName" width="80" headerAlign="center">
								字段名 <input property="editor" class="mini-textbox" />
							</div>
						</div>
					</div>
				</div>
				<div title="自定义SQL" showCloseButton="false" name="customSQL" visible="false">
					<div>
						<div>
							条件字段:<input id="availableColumn" class="mini-combobox" showNullItem="true" nullItemText="可选条件列头" valueField="fieldName"
								textField="fieldLabel" onvalueChanged="varsChanged" /> 常量:<input id="constantItem" class="mini-combobox" showNullItem="true"
								nullItemText="可用常量" url="${ctxPath}/sys/core/public/getConstantItem.do" valueField="key" textField="val"
								onvalueChanged="constantChanged" />
						</div>
						<ul>
							<li>params存放传入参数，为一个Map数据结构。</li>
							<li>可以使用params.containsKey("变量名")判断上下文是否有对应的变量。</li>
						</ul>

						<textarea id="sqlDiy" emptyText="请输入sql" rows="10" cols="100" width="500" height="250"></textarea>
					</div>
				</div>

			</div>
		</form>

		<rx:formScript formId="form1" baseUrl="sys/echarts/echartsCustom" entityName="com.redxun.sys.echarts.entity.SysEchartsCustom" />
	</div>

	<script src="${ctxPath}/scripts/sys/echarts/echartsCustom.js?version=${version}"></script>
	<script type="text/javascript">
		var id = "${echartsCustom.id}";
		var tableType = "${echartsCustom.table}";
		var sysPath = '${ctxPath}';
		
		$(function() {
			initType();
			loadQuery(id);
			loadTitle('${echartsCustom.titleField}');
			loadLegendHeatmap('${echartsCustom.legendField}');
			loadGrid('${echartsCustom.gridField}');
			loadSeries('${echartsCustom.seriesField}');
			loadTheme('${echartsCustom.theme}');
			loadTree('${echartsCustom.treeId}');
			var sqlText = $("#sql");
	        sqlText.attr("disabled","disabled");
		});
		
		//grid属性设置
		function setGrid(){
			var grid = {};
			grid.top = mini.get("grid-top").getValue();
			grid.right = mini.get("grid-right").getValue();
			grid.bottom = mini.get("grid-bottom").getValue();
			grid.left = mini.get("grid-left").getValue();
			var _gridField = {
				name : "gridField",
				value : grid
			}
			return _gridField;
		}
		
		//视觉设置
		function loadLegendHeatmap(legend){
			if(legend == "")
				return false;
			legend = JSON.parse(legend);
			mini.get("legend-show").setValue(legend.show? "0" : "1");
			mini.get("legend-type").setValue(legend.type);
			mini.get("legend-x").setValue(legend.x);
			mini.get("legend-y").setValue(legend.y);
			mini.get("legend-orient").setValue(legend.orient);
			mini.get("legend-calculable").setValue(legend.calculable);
		}
		
		//保存
		function selfSaveData() {
			form.validate();
			if (!form.isValid())
				return;
			
			//数据字段处理
			var dataGridQuery = mini.get('gridQuery').getData();
			var queryData = [];
			for (var i = 0; i < dataGridQuery.length; i++) {
				var obj = {};
				obj.comment = dataGridQuery[i].comment;
				obj.fieldName = dataGridQuery[i].fieldName;
				queryData.push(obj);
			}
			if (queryData.length < 1) {
				alert("数据字段必须设置！");
				return;
			}
			var queryField = {
				name : 'dataField',
				value : queryData
			}
			
			//获取自定义查询SQL构建类型
			var type = mini.get("sqlBuildType").getValue();
			
			//x轴设置
			var dataGridXAxis = mini.get('gridXAxis').getData();
			var xAxisData = [];
			for (var i = 0; i < dataGridXAxis.length; i++) {
				var obj = {};
				obj.comment = dataGridXAxis[i].comment;
				obj.fieldName = dataGridXAxis[i].fieldName;
				xAxisData.push(obj);
			}
			var xAxisField = {
				name : 'xAxisDataField',
				value : xAxisData
			}
			
			//条件选择字段设置
			var dataGridWhere = mini.get('gridWhere').getData();
			var whereData = [];
			for (var i = 0; i < dataGridWhere.length; i++){
				var obj = {};
				obj.comment = dataGridWhere[i].comment;
				obj.fieldName = dataGridWhere[i].fieldName;
				obj.valueSource = dataGridWhere[i].valueSource;
				whereData.push(obj);
			}
			var whereField = {
				name : 'whereField',
				value : whereData
			}
			
			//下钻字段设置
			var drillDown = {};
			drillDown.isDrillDown = mini.get("openDrillDown").getValue();
			drillDown.drillDownMethod = mini.get("drillDownMethod").getValue();
			drillDown.openWindowKey = mini.get("openWindowKey").getValue();
			drillDown.openWindowUrl = mini.get("openWindowUrl").getValue();
			drillDown.drillDownKey = mini.get("drillDownKey").getValue();
			var dataGridDrillDown = mini.get('drillDown').getData();
			var drillDownData = [];
			for(var i = 0; i < dataGridDrillDown.length; i++){
				var obj = {};
				obj.comment = dataGridDrillDown[i].comment;
				obj.fieldName = dataGridDrillDown[i].fieldName;
				drillDownData.push(obj);
			}
			drillDown.drillDownField = drillDownData;
			var drillDownField = {
				name : 'drillDownField',
				value : drillDown
			}
			
			formData = $("#form1").serializeArray();

			if (queryData.length > 0)
				formData.push(queryField);
			if (xAxisData.length > 0)
				formData.push(xAxisField);
			if (whereData.length > 0)
				formData.push(whereField);
			/* if (drillDownData.length > 0) */
			formData.push(drillDownField);

			for (var i = 0; i < formData.length; i++) {
				if (formData[i]['name'] == 'table') {
					formData[i]['value'] = tableType == 1 ? '1' : '0';
					break;
				}
			}
			if (type != "table") { //保存sql
				formData.push({
					name : "sql",
					value : sqlEditor.getValue()
				});
			}
			
			formData.push(setTitle());
			formData.push(setLegend());
			formData.push(setGrid());
			
			//系列列表设置
			var series = {};
			series.type = "heatmap";
			series.radius = [mini.get("series-minRadius").getValue(), mini.get("series-maxRadius").getValue()];
			series.labelShow = mini.get("series-labelShow").getValue();
			//series.center = [mini.get("series-center-h").getValue().replace(" ", "")==""?0:mini.get("series-center-h").getValue(), 
			//		mini.get("series-center-v").getValue().replace(" ", "")==""?0:mini.get("series-center-v").getValue()];
			var _seriesField = {
				name : "seriesField",
				value: series
			}
			formData.push(_seriesField);
			
			var jsonObj = formToObject(formData);

			var formJson = JSON.stringify(jsonObj);

			var postData = {
				json : formJson
			}
			//console.log(formJson);
			saveEchartsDetail(id, mini.getByName("key").getValue(), postData);
		}
	</script>
</body>
</html>