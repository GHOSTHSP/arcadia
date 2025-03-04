    -- ****************************************************************************
    -- If any update to this file, MUST sync the content to
    -- configMap under deploy/charts/arcadia/templates/pg-init-data-configmap.yaml
    -- ****************************************************************************

    CREATE TABLE IF NOT EXISTS public.data_process_task
    (
        id character varying(32) COLLATE pg_catalog."default" NOT NULL,
        name character varying(64) COLLATE pg_catalog."default",
        file_type character varying(32) COLLATE pg_catalog."default",
        status character varying(32) COLLATE pg_catalog."default",
        pre_data_set_name character varying(32) COLLATE pg_catalog."default",
        pre_data_set_version character varying(32) COLLATE pg_catalog."default",
        pre_version_data_set_name character varying(64) COLLATE pg_catalog."default",
        file_names jsonb,
        post_data_set_name character varying(32) COLLATE pg_catalog."default",
        post_data_set_version character varying(32) COLLATE pg_catalog."default",
        data_process_config_info jsonb,
        start_datetime character varying(32) COLLATE pg_catalog."default",
        end_datetime character varying(32) COLLATE pg_catalog."default",
        create_datetime character varying(32) COLLATE pg_catalog."default",
        create_user character varying(32) COLLATE pg_catalog."default",
        create_program character varying(64) COLLATE pg_catalog."default",
        update_datetime character varying(32) COLLATE pg_catalog."default",
        update_user character varying(32) COLLATE pg_catalog."default",
        update_program character varying(64) COLLATE pg_catalog."default",
        namespace character varying(64) COLLATE pg_catalog."default",
        current_log_id character varying(32) COLLATE pg_catalog."default",
        CONSTRAINT data_process_task_pkey PRIMARY KEY (id)
    );

    COMMENT ON COLUMN public.data_process_task.current_log_id IS '当前日志Id';
    COMMENT ON COLUMN public.data_process_task.pre_version_data_set_name IS '处理前数据集版本信息';

    CREATE TABLE IF NOT EXISTS public.data_process_task_detail
    (
        id character varying(32) COLLATE pg_catalog."default" NOT NULL,
        task_id character varying(32) COLLATE pg_catalog."default",
        file_name character varying(512) COLLATE pg_catalog."default",
        transform_type character varying(64) COLLATE pg_catalog."default",
        pre_content text COLLATE pg_catalog."default",
        post_content text COLLATE pg_catalog."default",
        create_datetime character varying(32) COLLATE pg_catalog."default",
        create_user character varying(32) COLLATE pg_catalog."default",
        create_program character varying(64) COLLATE pg_catalog."default",
        update_datetime character varying(32) COLLATE pg_catalog."default",
        update_user character varying(32) COLLATE pg_catalog."default",
        update_program character varying(32) COLLATE pg_catalog."default",
        document_id character varying(32) COLLATE pg_catalog."default",
        document_chunk_id character varying(32) COLLATE pg_catalog."default",
        status character varying(64) COLLATE pg_catalog."default",
        error_message text COLLATE pg_catalog."default",
        CONSTRAINT data_process_detail_pkey PRIMARY KEY (id)
    );

    COMMENT ON TABLE public.data_process_task_detail IS '数据处理详情';
    COMMENT ON COLUMN public.data_process_task_detail.id IS '主键';
    COMMENT ON COLUMN public.data_process_task_detail.task_id IS '任务Id';
    COMMENT ON COLUMN public.data_process_task_detail.file_name IS '文件名称';
    COMMENT ON COLUMN public.data_process_task_detail.transform_type IS '转换类型';
    COMMENT ON COLUMN public.data_process_task_detail.pre_content IS '处理前的内容';
    COMMENT ON COLUMN public.data_process_task_detail.post_content IS '处理后的内容';
    COMMENT ON COLUMN public.data_process_task_detail.create_datetime IS '创建时间';
    COMMENT ON COLUMN public.data_process_task_detail.create_user IS '创建用户';
    COMMENT ON COLUMN public.data_process_task_detail.create_program IS '创建程序';
    COMMENT ON COLUMN public.data_process_task_detail.update_datetime IS '更新时间';
    COMMENT ON COLUMN public.data_process_task_detail.update_user IS '更新用户';
    COMMENT ON COLUMN public.data_process_task_detail.update_program IS '更新程序';
    COMMENT ON COLUMN public.data_process_task_detail.document_id IS '文档id';
    COMMENT ON COLUMN public.data_process_task_detail.document_chunk_id IS '文档chunk id';
    COMMENT ON COLUMN public.data_process_task_detail.status IS '状态';
    COMMENT ON COLUMN public.data_process_task_detail.error_message IS '错误信息';

    CREATE TABLE public.data_process_task_question_answer (
        id varchar(32) NOT NULL, -- 主键
        task_id varchar(32) NULL, -- 任务Id
        file_name varchar(512) NULL, -- 文件名称
        question text NULL, -- 问题
        answer text NULL, -- 答案
        create_datetime varchar(32) NULL, -- 创建时间
        create_user varchar(32) NULL, -- 创建用户
        create_program varchar(64) NULL, -- 创建程序
        update_datetime varchar(32) NULL, -- 更新时间
        update_user varchar(32) NULL, -- 更新用户
        update_program varchar(32) NULL, -- 更新程序
        document_id character varying(32) COLLATE pg_catalog."default",
        document_chunk_id character varying(32) COLLATE pg_catalog."default",
        CONSTRAINT data_process_task_question_answer_pkey PRIMARY KEY (id)
    );
    COMMENT ON TABLE public.data_process_task_question_answer IS '数据处理问题答案';

    COMMENT ON COLUMN public.data_process_task_question_answer.id IS '主键';
    COMMENT ON COLUMN public.data_process_task_question_answer.task_id IS '任务Id';
    COMMENT ON COLUMN public.data_process_task_question_answer.file_name IS '文件名称';
    COMMENT ON COLUMN public.data_process_task_question_answer.question IS '问题';
    COMMENT ON COLUMN public.data_process_task_question_answer.answer IS '答案';
    COMMENT ON COLUMN public.data_process_task_question_answer.create_datetime IS '创建时间';
    COMMENT ON COLUMN public.data_process_task_question_answer.create_user IS '创建用户';
    COMMENT ON COLUMN public.data_process_task_question_answer.create_program IS '创建程序';
    COMMENT ON COLUMN public.data_process_task_question_answer.update_datetime IS '更新时间';
    COMMENT ON COLUMN public.data_process_task_question_answer.update_user IS '更新用户';
    COMMENT ON COLUMN public.data_process_task_question_answer.update_program IS '更新程序';
    COMMENT ON COLUMN public.data_process_task_question_answer.document_id IS '文档id';
    COMMENT ON COLUMN public.data_process_task_question_answer.document_chunk_id IS '文档chunk id';

    CREATE TABLE IF NOT EXISTS public.data_process_task_document
    (
        id character varying(64) COLLATE pg_catalog."default" NOT NULL,
        file_name character varying(512) COLLATE pg_catalog."default",
        status character varying(64) COLLATE pg_catalog."default",
        process_info text COLLATE pg_catalog."default",
        start_time character varying(32) COLLATE pg_catalog."default",
        end_time character varying(32) COLLATE pg_catalog."default",
        progress character varying(32) COLLATE pg_catalog."default",
        chunk_size character varying(64) COLLATE pg_catalog."default",
        task_id character varying(32) COLLATE pg_catalog."default",
        create_datetime character varying(32) COLLATE pg_catalog."default",
        create_user character varying(32) COLLATE pg_catalog."default",
        create_program character varying(64) COLLATE pg_catalog."default",
        update_datetime character varying(32) COLLATE pg_catalog."default",
        update_user character varying(32) COLLATE pg_catalog."default",
        update_program character varying(32) COLLATE pg_catalog."default",
        from_source_type character(64) COLLATE pg_catalog."default",
        from_source_path character varying(4096) COLLATE pg_catalog."default",
        document_type character varying(64) COLLATE pg_catalog."default",
        CONSTRAINT data_process_task_document_pkey PRIMARY KEY (id)
    );

    COMMENT ON TABLE public.data_process_task_document IS '数据处理任务文档';
    COMMENT ON COLUMN public.data_process_task_document.id IS '主键';
    COMMENT ON COLUMN public.data_process_task_document.file_name IS '文件名称';
    COMMENT ON COLUMN public.data_process_task_document.status IS '状态 如not_start, doing, success, fail';
    COMMENT ON COLUMN public.data_process_task_document.process_info IS '处理信息';
    COMMENT ON COLUMN public.data_process_task_document.start_time IS '开始时间';
    COMMENT ON COLUMN public.data_process_task_document.end_time IS '结束时间';
    COMMENT ON COLUMN public.data_process_task_document.progress IS '进度';
    COMMENT ON COLUMN public.data_process_task_document.chunk_size IS '文本拆分数量';
    COMMENT ON COLUMN public.data_process_task_document.task_id IS '任务id';
    COMMENT ON COLUMN public.data_process_task_document.create_datetime IS '创建时间';
    COMMENT ON COLUMN public.data_process_task_document.create_user IS '创建用户';
    COMMENT ON COLUMN public.data_process_task_document.create_program IS '创建程序';
    COMMENT ON COLUMN public.data_process_task_document.update_datetime IS '更新时间';
    COMMENT ON COLUMN public.data_process_task_document.update_user IS '更新用户';
    COMMENT ON COLUMN public.data_process_task_document.update_program IS '更新程序';
    COMMENT ON COLUMN public.data_process_task_document.from_source_type IS '如minio等';
    COMMENT ON COLUMN public.data_process_task_document.from_source_path IS '文件路径, minio的需要包括bucket的名称';
    COMMENT ON COLUMN public.data_process_task_document.document_type IS '文档类型 如txt web_url pdf等';

    CREATE TABLE IF NOT EXISTS public.data_process_task_detail_preview
    (
        id character varying(32) COLLATE pg_catalog."default" NOT NULL,
        task_id character varying(32) COLLATE pg_catalog."default",
        file_name character varying(512) COLLATE pg_catalog."default",
        transform_type character varying(64) COLLATE pg_catalog."default",
        pre_content text COLLATE pg_catalog."default",
        post_content text COLLATE pg_catalog."default",
        create_datetime character varying(32) COLLATE pg_catalog."default",
        create_user character varying(32) COLLATE pg_catalog."default",
        create_program character varying(64) COLLATE pg_catalog."default",
        update_datetime character varying(32) COLLATE pg_catalog."default",
        update_user character varying(32) COLLATE pg_catalog."default",
        update_program character varying(32) COLLATE pg_catalog."default",
        CONSTRAINT data_process_detail_preview_pkey PRIMARY KEY (id)
    );

    COMMENT ON TABLE public.data_process_task_detail_preview IS '数据处理详情预览';
    COMMENT ON COLUMN public.data_process_task_detail_preview.id IS '主键';
    COMMENT ON COLUMN public.data_process_task_detail_preview.task_id IS '任务Id';
    COMMENT ON COLUMN public.data_process_task_detail_preview.file_name IS '文件名称';
    COMMENT ON COLUMN public.data_process_task_detail_preview.transform_type IS '转换类型';
    COMMENT ON COLUMN public.data_process_task_detail_preview.pre_content IS '处理前的内容';
    COMMENT ON COLUMN public.data_process_task_detail_preview.post_content IS '处理后的内容';
    COMMENT ON COLUMN public.data_process_task_detail_preview.create_datetime IS '创建时间';
    COMMENT ON COLUMN public.data_process_task_detail_preview.create_user IS '创建用户';
    COMMENT ON COLUMN public.data_process_task_detail_preview.create_program IS '创建程序';
    COMMENT ON COLUMN public.data_process_task_detail_preview.update_datetime IS '更新时间';
    COMMENT ON COLUMN public.data_process_task_detail_preview.update_user IS '更新用户';
    COMMENT ON COLUMN public.data_process_task_detail_preview.update_program IS '更新程序';

    CREATE TABLE IF NOT EXISTS public.data_process_task_document_chunk
    (
        id character varying(32) COLLATE pg_catalog."default" NOT NULL,
        document_id character varying(32) COLLATE pg_catalog."default",
        status character varying(32) COLLATE pg_catalog."default",
        start_time character varying(32) COLLATE pg_catalog."default",
        end_time character varying(32) COLLATE pg_catalog."default",
        create_datetime character varying(32) COLLATE pg_catalog."default",
        create_user character varying(32) COLLATE pg_catalog."default",
        create_program character varying(64) COLLATE pg_catalog."default",
        update_datetime character varying(32) COLLATE pg_catalog."default",
        update_user character varying(32) COLLATE pg_catalog."default",
        update_program character varying(32) COLLATE pg_catalog."default",
        content text COLLATE pg_catalog."default",
        task_id character varying(32) COLLATE pg_catalog."default",
        content_clean text COLLATE pg_catalog."default",
        content_privacy text COLLATE pg_catalog."default",
        meta_info text COLLATE pg_catalog."default",
        process_info text COLLATE pg_catalog."default",
        page_number character varying(64) COLLATE pg_catalog."default",
        CONSTRAINT data_process_task_document_chunk_pkey PRIMARY KEY (id)
    );

    COMMENT ON COLUMN public.data_process_task_document_chunk.id IS '主键id';
    COMMENT ON COLUMN public.data_process_task_document_chunk.document_id IS '文档id';
    COMMENT ON COLUMN public.data_process_task_document_chunk.status IS '状态';
    COMMENT ON COLUMN public.data_process_task_document_chunk.start_time IS '开始时间';
    COMMENT ON COLUMN public.data_process_task_document_chunk.end_time IS '结束时间';
    COMMENT ON COLUMN public.data_process_task_document_chunk.create_datetime IS '创建时间';
    COMMENT ON COLUMN public.data_process_task_document_chunk.create_user IS '创建用户';
    COMMENT ON COLUMN public.data_process_task_document_chunk.create_program IS '创建程序';
    COMMENT ON COLUMN public.data_process_task_document_chunk.update_datetime IS '更新时间';
    COMMENT ON COLUMN public.data_process_task_document_chunk.update_user IS '更新用户';
    COMMENT ON COLUMN public.data_process_task_document_chunk.update_program IS '更新程序';
    COMMENT ON COLUMN public.data_process_task_document_chunk.content IS 'chunk内容';
    COMMENT ON COLUMN public.data_process_task_document_chunk.task_id IS '数据处理任务 id';
    COMMENT ON COLUMN public.data_process_task_document_chunk.content_clean IS '清洗过之后的chunk内容';
    COMMENT ON COLUMN public.data_process_task_document_chunk.content_privacy IS '对清洗后的内容进行去隐私处理';
    COMMENT ON COLUMN public.data_process_task_document_chunk.meta_info IS 'json结构, 信息包括文档名称，所在页数等。';
    COMMENT ON COLUMN public.data_process_task_document_chunk.process_info IS 'json结构 数据处理信息如进行了哪些清洗';
    COMMENT ON COLUMN public.data_process_task_document_chunk.page_number IS '所在页数';

    CREATE TABLE IF NOT EXISTS public.data_process_task_question_answer_clean
    (
        id character varying(32) COLLATE pg_catalog."default" NOT NULL,
        task_id character varying(32) COLLATE pg_catalog."default",
        document_id character varying(32) COLLATE pg_catalog."default",
        document_chunk_id character varying(32) COLLATE pg_catalog."default",
        file_name character varying(512) COLLATE pg_catalog."default",
        question text COLLATE pg_catalog."default",
        answer text COLLATE pg_catalog."default",
        create_datetime character varying(32) COLLATE pg_catalog."default",
        create_user character varying(32) COLLATE pg_catalog."default",
        create_program character varying(64) COLLATE pg_catalog."default",
        update_datetime character varying(32) COLLATE pg_catalog."default",
        update_user character varying(32) COLLATE pg_catalog."default",
        update_program character varying(32) COLLATE pg_catalog."default",
        CONSTRAINT data_process_task_question_answer_clean_pkey PRIMARY KEY (id)
    );

    COMMENT ON TABLE public.data_process_task_question_answer_clean IS '数据处理问题和答案';
    COMMENT ON COLUMN public.data_process_task_question_answer_clean.id IS '主键';
    COMMENT ON COLUMN public.data_process_task_question_answer_clean.task_id IS '任务Id';
    COMMENT ON COLUMN public.data_process_task_question_answer_clean.document_id IS '文档id';
    COMMENT ON COLUMN public.data_process_task_question_answer_clean.document_chunk_id IS '文档chunk id';
    COMMENT ON COLUMN public.data_process_task_question_answer_clean.file_name IS '文件名称';
    COMMENT ON COLUMN public.data_process_task_question_answer_clean.question IS '问题';
    COMMENT ON COLUMN public.data_process_task_question_answer_clean.answer IS '答案';
    COMMENT ON COLUMN public.data_process_task_question_answer_clean.create_datetime IS '创建时间';
    COMMENT ON COLUMN public.data_process_task_question_answer_clean.create_user IS '创建用户';
    COMMENT ON COLUMN public.data_process_task_question_answer_clean.create_program IS '创建程序';
    COMMENT ON COLUMN public.data_process_task_question_answer_clean.update_datetime IS '更新时间';
    COMMENT ON COLUMN public.data_process_task_question_answer_clean.update_user IS '更新用户';
    COMMENT ON COLUMN public.data_process_task_question_answer_clean.update_program IS '更新程序';


    CREATE TABLE IF NOT EXISTS public.data_process_task_log
    (
        id character varying(32) COLLATE pg_catalog."default",
        task_id character varying(32) COLLATE pg_catalog."default",
        type character varying(32) COLLATE pg_catalog."default",
        start_datetime character varying(64) COLLATE pg_catalog."default",
        end_datetime character varying(64) COLLATE pg_catalog."default",
        status character varying(64) COLLATE pg_catalog."default",
        error_msg text COLLATE pg_catalog."default",
        create_datetime character varying(64) COLLATE pg_catalog."default",
        create_user character varying(64) COLLATE pg_catalog."default",
        create_program character varying(64) COLLATE pg_catalog."default",
        update_datetime character varying(64) COLLATE pg_catalog."default",
        update_user character varying(64) COLLATE pg_catalog."default",
        update_program character varying(64) COLLATE pg_catalog."default"
    );

    COMMENT ON TABLE public.data_process_task_log IS '数据处理日志表';
    COMMENT ON COLUMN public.data_process_task_log.id IS 'id';
    COMMENT ON COLUMN public.data_process_task_log.task_id IS '任务id';
    COMMENT ON COLUMN public.data_process_task_log.type IS '执行类型';
    COMMENT ON COLUMN public.data_process_task_log.start_datetime IS '任务开始时间';
    COMMENT ON COLUMN public.data_process_task_log.end_datetime IS '结束时间';
    COMMENT ON COLUMN public.data_process_task_log.status IS '状态';
    COMMENT ON COLUMN public.data_process_task_log.error_msg IS '错误信息';
    COMMENT ON COLUMN public.data_process_task_log.create_datetime IS '创建时间';
    COMMENT ON COLUMN public.data_process_task_log.create_user IS '创建人';
    COMMENT ON COLUMN public.data_process_task_log.create_program IS '创建程序';
    COMMENT ON COLUMN public.data_process_task_log.update_datetime IS '更新时间';
    COMMENT ON COLUMN public.data_process_task_log.update_user IS '更新人';
    COMMENT ON COLUMN public.data_process_task_log.update_program IS '更新程序';


    CREATE TABLE IF NOT EXISTS public.data_process_task_stage_log
    (
        id character varying(32) COLLATE pg_catalog."default",
        task_id character varying(32) COLLATE pg_catalog."default",
        log_id character varying(32) COLLATE pg_catalog."default",
        log_datetime character varying(32) COLLATE pg_catalog."default",
        file_name character varying(64) COLLATE pg_catalog."default",
        stage_name character varying(1024) COLLATE pg_catalog."default",
        stage_status character varying(64) COLLATE pg_catalog."default",
        stage_detail text COLLATE pg_catalog."default",
        error_msg text COLLATE pg_catalog."default",
        create_datetime character varying(64) COLLATE pg_catalog."default",
        create_user character varying(64) COLLATE pg_catalog."default",
        create_program character varying(64) COLLATE pg_catalog."default",
        update_datetime character varying(64) COLLATE pg_catalog."default",
        update_user character varying(64) COLLATE pg_catalog."default",
        update_program character varying(64) COLLATE pg_catalog."default"
    );

    COMMENT ON TABLE public.data_process_task_stage_log IS '数据处理日志详情表';
    COMMENT ON COLUMN public.data_process_task_stage_log.id IS 'id';
    COMMENT ON COLUMN public.data_process_task_stage_log.task_id IS '任务id';
    COMMENT ON COLUMN public.data_process_task_stage_log.log_id IS 'task log id';
    COMMENT ON COLUMN public.data_process_task_stage_log.log_datetime IS '日志时间';
    COMMENT ON COLUMN public.data_process_task_stage_log.file_name IS '文件名称';
    COMMENT ON COLUMN public.data_process_task_stage_log.stage_name IS '阶段名称';
    COMMENT ON COLUMN public.data_process_task_stage_log.stage_status IS '阶段状态';
    COMMENT ON COLUMN public.data_process_task_stage_log.stage_detail IS '阶段详细';
    COMMENT ON COLUMN public.data_process_task_stage_log.error_msg IS '错误信息';
    COMMENT ON COLUMN public.data_process_task_stage_log.create_datetime IS '创建时间';
    COMMENT ON COLUMN public.data_process_task_stage_log.create_user IS '创建人';
    COMMENT ON COLUMN public.data_process_task_stage_log.create_program IS '创建程序';
    COMMENT ON COLUMN public.data_process_task_stage_log.update_datetime IS '更新时间';
    COMMENT ON COLUMN public.data_process_task_stage_log.update_user IS '更新人';
    COMMENT ON COLUMN public.data_process_task_stage_log.update_program IS '更新程序';

    CREATE TABLE IF NOT EXISTS data_process_task_document_web_url
    (
        id varchar(32) not null
            constraint data_process_task_document_web_url_pkey
                primary key,
        task_id varchar(32),
        document_id varchar(32),
        level varchar(32),
        web_url varchar(4096),
        title varchar(1024),
        description text,
        content text,
        content_clean text,
        language varchar(32),
        status varchar(4),
        error_message text,
        create_datetime varchar(32),
        create_user varchar(32),
        create_program varchar(64),
        update_datetime varchar(32),
        update_user varchar(32),
        update_program varchar(32)
    );

    CREATE TABLE IF NOT EXISTS data_process_task_document_image
    (
        id varchar(32) not null
            constraint data_process_task_document_image_pkey
                primary key,
        task_id varchar(32),
        document_id varchar(512),
        url varchar(1024),
        image_path varchar(4096),
        ocr_content text,
        image_info text,
        create_datetime varchar(32),
        create_user varchar(32),
        create_program varchar(64),
        update_datetime varchar(32),
        update_user varchar(32),
        update_program varchar(32),
        meta_info text
    );

    CREATE TABLE IF NOT EXISTS data_process_task_question_answer_remove_duplicate_tmp
    (
        id varchar(32),
        task_id varchar(32),
        document_id varchar(32),
        question text,
        answer text,
        question_vector vector,
        answer_vector vector,
        create_datetime varchar(32)
    );

