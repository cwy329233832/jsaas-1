alter table ACT_RU_TASK add CREATE_BY_ VARCHAR2(64) null ;
alter table ACT_RU_TASK add UPDATE_BY_ VARCHAR2(64) null ;
alter table ACT_RU_TASK add UPDATE_TIME_ TIMESTAMP null ;
alter table ACT_RU_TASK add SOL_ID_ varchar(64) null;
alter table ACT_RU_TASK add AGENT_USER_ID_ varchar(64) null;

alter table ACT_RU_TASK add RC_TASK_ID_ VARCHAR2(64);  
alter table ACT_RU_TASK add CM_LEVEL_ INTEGER;
alter table ACT_RU_TASK add TASK_TYPE_ VARCHAR2(20);
alter table ACT_RU_TASK add GEN_CM_TASK_ VARCHAR2(20);
alter table ACT_RU_TASK add CM_FUSRID_ VARCHAR2(64);
alter table ACT_RU_TASK add CM_TASK_ID_ VARCHAR2(64) null;
alter table ACT_RU_TASK add ENABLE_MOBILE_  integer default 0;

alter table ACT_RU_TASK add TOKEN_ VARCHAR2(64);
alter table ACT_RU_TASK add URGENT_TIMES_ integer default 0;
alter table ACT_RU_TASK add RUN_PATH_ID_ VARCHAR2(64);
alter table ACT_RU_TASK add OVERTIME_ VARCHAR2(1024) null;
alter table ACT_RU_TASK add SOL_KEY_ varchar(100) null; 
alter table ACT_RU_TASK add INST_ID_ varchar(100) null;

COMMENT ON COLUMN ACT_RU_TASK.SOL_KEY_ IS '业务解决方案KEY';
COMMENT ON COLUMN ACT_RU_TASK.INST_ID_ IS '流程实例ID';
COMMENT ON COLUMN ACT_RU_TASK.CREATE_BY_ IS '创建人ID';
COMMENT ON COLUMN ACT_RU_TASK.UPDATE_BY_ IS '更新人ID';
COMMENT ON COLUMN ACT_RU_TASK.UPDATE_TIME_ IS '更新时间';
COMMENT ON COLUMN ACT_RU_TASK.SOL_ID_ IS '业务解决方案ID';
COMMENT ON COLUMN ACT_RU_TASK.AGENT_USER_ID_ IS '代理人ID';

COMMENT ON COLUMN ACT_RU_TASK.TOKEN_ IS '令牌';
COMMENT ON COLUMN ACT_RU_TASK.URGENT_TIMES_ IS '催办次数';
COMMENT ON COLUMN ACT_RU_TASK.RC_TASK_ID_ IS '原沟通任务Id';  
COMMENT ON COLUMN ACT_RU_TASK.CM_LEVEL_ IS '沟通层次';
COMMENT ON COLUMN ACT_RU_TASK.TASK_TYPE_  IS '任务类型';
COMMENT ON COLUMN ACT_RU_TASK.GEN_CM_TASK_  IS '是否产生沟通任务';
COMMENT ON COLUMN ACT_RU_TASK.CM_FUSRID_ IS '发起沟通人';

COMMENT ON COLUMN ACT_RU_TASK.RUN_PATH_ID_ IS '流程实例单号';
COMMENT ON COLUMN ACT_RU_TASK.OVERTIME_ IS '超时设置';
alter table ACT_RU_TASK add timeout_status_ VARCHAR2(20);


CREATE INDEX IDX_BPMINST_ACTINSTID ON BPM_INST (ACT_INST_ID_);
CREATE INDEX IDX_INSTDATA_INSTID ON BPM_INST_DATA (INST_ID_);
CREATE INDEX IDX_OPINIONTEMP_INSTID ON BPM_OPINION_TEMP (INST_ID_,TYPE_);
CREATE INDEX IDX_RUPATH_ACTINSTID ON BPM_RU_PATH (ACT_INST_ID_);



