
package com.redxun.oa.ats.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.oa.ats.dao.AtsImportPlanDao;
import com.redxun.oa.ats.entity.AtsImportPlan;

/**
 * 
 * <pre> 
 * 描述：打卡导入方案 处理接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsImportPlanManager extends MybatisBaseManager<AtsImportPlan>{
	@Resource
	private AtsImportPlanDao atsImportPlanDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsImportPlanDao;
	}
	
	
	
	public AtsImportPlan getAtsImportPlan(String uId){
		AtsImportPlan atsImportPlan = get(uId);
		return atsImportPlan;
	}
}
