package com.redxun.wx.ent.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;

import com.redxun.sys.core.util.SysPropertiesUtil;
import com.redxun.wx.ent.entity.WxEntAgent;

/**
 * 企业微信API地址。
 * @author ray
 *
 */
public class ApiUrl {

	private static String entBaseAddr="https://qyapi.weixin.qq.com";
	
	private static String getEntBaseAddr(){
		String entwxaddr=SysPropertiesUtil.getGlobalProperty("wx_entaddr", entBaseAddr);
		return entwxaddr;
	}
	
	/**
	 * 获取token的url。
	 * @param corpId	企业id
	 * @param secret	密钥
	 * @return
	 */
	//
	public static String getTokenUrl(String corpId,String secret){
		String entwxaddr=getEntBaseAddr();
		return entwxaddr +"/cgi-bin/gettoken?corpid="+corpId+"&corpsecret="+ secret;
	}
	
	
	/**
	 * 获取用户信息。
	 * @param token
	 * @param code
	 * @return
	 */
	public static String getUserId(String token,String code){
		String entwxaddr=getEntBaseAddr();
		return entwxaddr +"/cgi-bin/user/getuserinfo?access_token="+token+"&code="+ code;
	}
	
	/**
	 * 上传其他素材URL。
	 * 	媒体文件类型，分别有图片（image）、语音（voice）、视频（video），普通文件(file)
	 * @param token	访问token
	 * @param type	文件类型。
	 * @return
	 */
	public static String getUploadUrl(String token,String type) {
		String entwxaddr=getEntBaseAddr();
		return entwxaddr +"/cgi-bin/media/upload?access_token="+ token+"&type="+type;
	}
	
	/**
	 * 返回下载URL
	 * @param token
	 * @param id
	 * @return
	 */
	public static String getDownloadUrl(String token,String id) {
		String entwxaddr=getEntBaseAddr();
		return entwxaddr +"/cgi-bin/media/get?access_token="+token+"&media_id=" +id;
	}
	
	
	/**
	 * 取得发送消息URL
	 * @param token
	 * @return
	 */
	public static String getSendMsgUrl(String token){
		String entwxaddr=getEntBaseAddr();
		return entwxaddr+ "/cgi-bin/message/send?access_token=" + token;
	}
	
	/**
	 * 创建用户URL。
	 * @param token
	 * @return
	 */
	public static String getUserCreateUrl(String token){
		String entwxaddr=getEntBaseAddr();
		return entwxaddr+ "/cgi-bin/user/create?access_token=" + token;
	}
	
	/**
	 * 获取用户明细URL。
	 * @param token
	 * @param userId
	 * @return
	 */
	public static String getUserDetailUrl(String token,String userId){
		String entwxaddr=getEntBaseAddr();
		return entwxaddr +"/cgi-bin/user/get?access_token="+token+"&userid="+ userId;
	}
	
	/**
	 * 更新用户API地址。
	 * @param token
	 * @return
	 */
	public static String getUpdUserUrl(String token){
		String entwxaddr=getEntBaseAddr();
		return entwxaddr+ "/cgi-bin/user/update?access_token="+ token;
	}
	
	/**
	 * 删除用户URL
	 * @param token
	 * @param userId
	 * @return
	 */
	public static String getDelUserUrl(String token,String userId){
		String entwxaddr=getEntBaseAddr();
		return entwxaddr+"/cgi-bin/user/delete?access_token="+token+"&userid="+userId;

	}
	
	/**
	 * 删除用户。
	 * @param token
	 * @return
	 */
	public static String getDelUsersUrl(String token){
		String entwxaddr=getEntBaseAddr();
		return entwxaddr+"/cgi-bin/user/batchdelete?access_token=" + token;
	}
	
	/**
	 * 根据部门获取人员数据。
	 * @param token
	 * @param departmentId
	 * @param fetchChild
	 * @return
	 */
	public static String getUsersByDepartmentUrl(String token,String departmentId,boolean fetchChild){
		String entwxaddr=getEntBaseAddr();
		return entwxaddr+"/cgi-bin/user/simplelist?access_token="+token
				+"&department_id="+departmentId+"&fetch_child=" +( fetchChild?"1" :"0");
	}
	
	/**
	 * 创建组织。
	 * @param token
	 * @return
	 */
	public static String getCreateDepartmentUrl(String token){
		String entwxaddr=getEntBaseAddr();
		return entwxaddr+"/cgi-bin/department/create?access_token=" + token;
	}
	
	/**
	 * 取得更新部门 url。
	 * @param token
	 * @return
	 */
	public static String getUpdDepartmentUrl(String token){
		String entwxaddr=getEntBaseAddr();
		return entwxaddr+"/cgi-bin/department/update?access_token="+ token;
	}
	
	/**
	 * 删除部门的URL
	 * @param token
	 * @param id
	 * @return
	 */
	public static String getDelDepartmentUrl(String token,String id){
		String entwxaddr=getEntBaseAddr();
		return entwxaddr+"/cgi-bin/department/delete?access_token="+token+"&id=" + id;
	}
	
	/**
	 * 获取部门列表。
	 * @param token
	 * @param id
	 * @return
	 */
	public static String getDepartmentsUrl(String token,String id){
		String entwxaddr=getEntBaseAddr();
		return entwxaddr +"/cgi-bin/department/list?access_token="+token+"&id="+ id;
	}
	
	/**
	 * 取得微信OAUTH地址。
	 * @param corpId
	 * @param agentId
	 * @param url
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	public static String getOAuthUrl(HttpServletRequest request, WxEntAgent agent,String url) throws UnsupportedEncodingException{		
		String redirectUrl="http://" +agent.getDomain(); 
		redirectUrl+=request.getContextPath() + "/proxy/" + agent.getId() + ".do?url="+ url;
		redirectUrl=URLEncoder.encode(redirectUrl,"utf-8");
		String openaddr=SysPropertiesUtil.getGlobalProperty("wx_openaddr", "https://open.weixin.qq.com");
		String rtnUrl=openaddr +"/connect/oauth2/authorize?appid="+agent.getCorpId()+
					"&redirect_uri="+redirectUrl+"&response_type=code&scope=SCOPE&agentid="+agent.getAgentId()+"&state=STATE#wechat_redirect";
		return rtnUrl;
	}

	
	
	/**
	 * 根据企业ID和密钥获取应用。
	 * @param token
	 * @return
	 */
	public static String getAppUrl(String token){
		String entwxaddr=getEntBaseAddr();
		return entwxaddr+ "/cgi-bin/agent/list?access_token="+token;
		
	}
	
	/**
	 * 获取应用基本信息。
	 * @param token
	 * @param agentId
	 * @return
	 */
	public static String getAppInfoByIdUrl(String token,String agentId){
		String entwxaddr=getEntBaseAddr();
		return entwxaddr+ "/cgi-bin/agent/get?access_token="+token+"&agentid="+agentId;
		
	}
	
	/**
	 * 取得设置应用的url。
	 * @param token
	 * @return
	 */
	public static String getAgentSetUrl(String token){
		String entwxaddr=getEntBaseAddr();
		return entwxaddr +"/cgi-bin/agent/set?access_token="+token;
	}
	
	/**
	 * 获取JS SDK票据。
	 * @param token
	 * @return
	 */
	public static String getJsApiUrl(String token){
		String entwxaddr=getEntBaseAddr();
		return entwxaddr +"/cgi-bin/get_jsapi_ticket?access_token="+token;
	}
	
	/**
	 * 
	 * @param token
	 * @return
	 */
	public static String getSignDataUrl(String token){
		String entwxaddr=getEntBaseAddr();
		return entwxaddr +"/cgi-bin/checkin/getcheckindata?access_token="+token;
	}
	
	
	
	
}
