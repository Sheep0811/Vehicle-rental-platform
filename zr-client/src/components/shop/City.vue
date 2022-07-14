<template>
  <div>
    <!-- 查询条件 -->
    <el-form :inline="true" :model="queryForm" style="text-align: left;">
      <el-form-item label="城市名称">
        <el-input v-model="queryForm.name" placeholder="城市名称"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="query">查询</el-button>
        <el-button type="primary" @click="openAdd" plain>新增</el-button>
      </el-form-item>
    </el-form>
    <!-- 数据列表 -->
    <el-table :data="tableData" style="width: 100%">
      <el-table-column prop="provinceId" label="provinceId" v-if="false"></el-table-column>
      <el-table-column prop="id" label="id" v-if="false"></el-table-column>
      <el-table-column prop="name3" label="省份名称" width="300">
      </el-table-column>
      <el-table-column prop="name" label="城市名称" width="300">
      </el-table-column>
      <el-table-column prop="createTime" label="新增时间" width="300">
      </el-table-column>
      <el-table-column fixed="right" label="操作" width="300">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="openEdit(scope.row)">编辑</el-button>
          <el-popconfirm title="确定删除吗?" @confirm="del(scope.row)">
            <el-button slot="reference" type="text" size="small">删除</el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页 -->
    <el-pagination v-show="total > 0" background @size-change="query" @current-change="query"
      :current-page.sync="queryForm.pageNum" :page-size.sync="queryForm.pageSize"
      layout="total,sizes,prev, pager, next,jumper" :total="total">
    </el-pagination>

    <el-dialog :title="title" :visible.sync="show" width="500px">
      <el-input type="hidden" :name="dialogType"></el-input>
      <el-form ref="form" :model="form" :rules="rules" label-width="60px">
        <el-form-item label="省份" prop="provinceId">
          <el-select v-model="form.provinceId" placeholder="请选择" style="width: 100%">
            <el-option v-for="item in provinces" :key="item.id" :label="item.name" :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="城市" prop="name">
          <el-input v-model="form.name" clearable></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">提 交</el-button>
        <el-button @click="show = false">取 消</el-button>

      </span>

    </el-dialog>
  </div>
</template>

<script>
  export default {
    name: 'City',
    data() {
      return {
        // 查询条件对象
        queryForm: {
          name: '',
          pageNum: 1,
          pageSize: 10
        },
        // 数据列表对象
        tableData: [],
        // 一共有多少条数据
        total: 0,
        // 对话框标题
        title: '',
        // 显示隐藏
        show: false,

        // 初始化表单对象
        form: {},
        // 初始化校验对象
        rules: {
          name3: [{
            required: true,
            message: '请输入省份',
            trigger: 'blur'
          }],
          name: [{
            required: true,
            message: '请输入城市',
            trigger: 'blur'
          }]
        },
        dialogType: 'add',
        //主键是否可以被编辑:默认可以编辑
        disabled: false,
        provinces:{},


      }
    },
    methods: {
      getp()
      {
        this.$axios({
          method: "post",
          url: "api/shop/province/getp",
        }).then(res => {
          this.provinces = res.data.obj;
          // console.info(this.provinces)
        }).catch(err => {
          console.info(err)
        });
      },
      query() {
        this.$axios({
          method: 'post',
          url: 'api/shop/city/list',
          data: this.queryForm
        }).then(res => {
          if (res.data.success) {
            this.tableData = res.data.obj.list;
            this.total = res.data.obj.total;
          } else {
            this.$message.error(res.data.msg);
          }
        }).catch(err => {
          console.info(err)
        });
      },
      openAdd() {
        //设置对话框标题
        this.title = "新增";
        //清空表单
        this.form = {};
        //主键可编辑
        this.disabled = false;
        //打开对话框
        this.show = true;
        //更改标识为新增
        this.dialogType = 'add';
        this.getp()

      },
      openEdit(row) {
        //设置对话框标题
        this.title = "编辑";
        //清空表单
        this.form = {};
        //主键不可以编辑
        this.disabled = true;
        //打开对话框
        this.show = true;
        //更改标识为编辑
        this.dialogType = 'edit';
        this.getp()
        this.form = Object.assign({}, row);
      },
      submitForm() {
        this.$refs['form'].validate((valid) => {
          if (valid) {
            if (this.dialogType == 'add') {
              this.$axios({
                method: 'post',
                url: 'api/shop/city/add',
                data: this.form
              }).then(res => {
                //关闭对话框
                this.show = false;
                //刷新页面
                this.query()
              }).catch(err => {
                console.info(err)
              });
            } else {
              this.$axios({
                method: 'post',
                url: 'api/shop/city/edit',
                data: this.form
              }).then(res => {
                //关闭对话框
                this.show = false;
                //刷新页面
                this.query()
              }).catch(err => {
                console.info(err)
              });
            }
          }
        });
      },
      del(row) {
        this.$axios({
          method: 'get',
          url: 'api/shop/city/del/' + row.id
        }).then(res => {
          //刷新页面
          this.query()
        }).catch(err => {
          console.info(err)
        });
      },
    },
    created() {
      this.query()

    }
  }
</script>

<style>

</style>
