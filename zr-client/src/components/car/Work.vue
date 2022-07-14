<template>
  <div>
    <!-- 查询条件 -->
    <el-form :inline="true" :model="queryForm" style="text-align: left;">
      <el-form-item label="订单编号" >
        <template slot-scope="scope">
          <el-button type="text" @click="shwoOrderDetail(scope.row)">{{scope.row.order.orderId}}</el-button>
        </template>
        <el-input v-model="queryForm.id" placeholder="订单编号" :clearable="true"></el-input>
      </el-form-item>
      <el-form-item label="客户编号">
        <el-input v-model="queryForm.customerId" placeholder="客户编号" :clearable="true"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="query">查询</el-button>
      </el-form-item>
    </el-form>
    <!-- 数据列表 -->
    <el-table :data="tableData" style="width: 100%" :header-cell-style="{background:'#f7f7f7',color:'#666666'}">
      <el-table-column prop="orderId" label="订单编号">
      </el-table-column>
      <el-table-column prop="customerId" label="客户账号">
      </el-table-column>
      <el-table-column prop="customerName" label="客户名称">
      </el-table-column>
      <el-table-column prop="carNo" label="车牌号码">
      </el-table-column>
      <el-table-column prop="outTime" label="出车时间">
      </el-table-column>
      <el-table-column prop="inTime" label="回车时间">
      </el-table-column>
      <el-table-column prop="status" label="状态">
      </el-table-column>
      <el-table-column label="操作" width="190px" align="left" header-align="center" fixed="right" >
        <template slot-scope="scope" >
          <el-button type="primary" @click="openEdit(scope.row)" size="small" icon="el-icon-view">编辑
          </el-button>

        </template>
      </el-table-column>
    </el-table>
    <!-- 分页 -->
    <el-pagination v-show="total > 0" background @size-change="query" @current-change="query"
      :current-page.sync="queryForm.pageNum" :page-size.sync="queryForm.pageSize"
      layout="total,sizes,prev, pager, next,jumper" :total="total">
    </el-pagination>
   <!-- 修改页面 -->
    <el-dialog :title="title" :visible.sync="show" width="500px">
      <el-input type="hidden" :name="dialogType"></el-input>
      <el-form :model="form" :rules="rules" ref="form">
      <el-form-item label="订单编号" prop="orderId">
        <el-input v-model="form.orderId" clearable></el-input>
      </el-form-item>
      <el-form-item label="客户账号" prop="customerId">
        <el-input v-model="form.customerId" clearable></el-input>
      </el-form-item>
      <el-form-item label="客户姓名" prop="customerName">
        <el-input v-model="form.customerName" clearable></el-input>
      </el-form-item>
      <el-form-item label="车牌号码" prop="carNo">
        <el-input v-model="form.carNo" clearable></el-input>
      </el-form-item>
      <el-form-item label="状态" prop="orderId">
        <el-select v-model="form.status" >
          <el-option label="出车" value="出车"></el-option>
          <el-option label="回车" value="回车"></el-option>
          <el-option label="整备" value="整备"></el-option>
        </el-select>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button type="primary" @click="submitForm">提交</el-button>
      <el-button @click="show = false">取消</el-button>
    </span>
    </el-dialog>

  </div>
</template>

<script>
  export default {
    name: 'Work',
    data() {
      return {
        queryForm: {
          id: '',
          customerId: '',
          pageNum: 1,
          pageSize: 10
        },
        tableData: [],
        //一共多少条数据
        total: 0,
        //对话框标题
        title: '',
        //显示/隐藏对话框
        show: false,
        //初始化表单对象
        form: {},
        rules: {
          orderId: [{
            required: true,
            message: '请输入订单编号',
            trigger: 'blur'
          }],
          customerId: [{
            required: true,
            message: '请输入客户账号',
            trigger: 'blur'
          }],
          customerName: [{
            required: true,
            message: '请输入客户姓名',
            trigger: 'blur'
          }],
          carNo: [{
              required: true,
              message: '请输入车牌号码',
              trigger: 'blur'
            },
          ]
        },
      };
    },
    methods: {


      query() {
        this.$axios({
          method: 'post',
          url: 'api/car/work/list',
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
      },
      submitForm() {
        if (this.dialogType == 'add') {
          this.$axios({
            method: 'post',
            url: 'api/car/work/add',
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
            url: 'api/car/work/edit',
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
      },

      openEdit(row) {
        //设置对话框标题
        this.title = "编辑";
        //清空表单
        this.form = {};
        //主键可编辑
        this.disabled = true;
        //打开对话框
        this.show = true;
        //更改标识为编辑
        this.dialogType = 'edit';
        this.form = Object.assign({}, row);
      },

    },
    created() {
      this.query();
    }
  }
</script>

<style>

</style>
