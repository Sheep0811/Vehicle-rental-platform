<template>
  <div>
    <el-form :inline="true" :model="queryForm" style="text-align: left;">
      <el-form-item label="合同名称">
        <el-input v-model="queryForm.name" placeholder="合同名称"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="query">查询</el-button>
        <el-button type="primary" @click="openAdd" plain>新增</el-button>
      </el-form-item>
    </el-form>
    <el-table :data="tableData" style="width: 100%">
      <el-table-column prop="name" label="合同名称" width="200px" style="">
      </el-table-column>
      <el-table-column prop="text" label="合同内容" width="500px">
      </el-table-column>
      <el-table-column prop="status" label="状态">
      </el-table-column>
      <el-table-column prop="createId" label="新增人员">
      </el-table-column>
      <el-table-column prop="createTime" label="新增时间" width="180px">
      </el-table-column>
      <el-table-column fixed="right" label="操作">
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
    <!-- 对话框 -->
    <el-dialog :title="title" :visible.sync="show" width="500px">
      <el-input type="hidden" :name="dialogType"></el-input>
      <el-form :model="form" :rules="rules" ref="form" label-width="100px" :inline="true">
        <el-form-item label="名称">
          <el-input v-model="form.name" clearable></el-input>
        </el-form-item>
      </el-form>
      <el-form :model="form" :rules="rules" ref="form" label-width="100px" :inline="true">
        <el-form-item label="合同内容">
          <el-input type="textarea" :autosize="{ minRows: 2, maxRows: 4}" placeholder="请输入内容" v-model="form.text"
            clearable>
          </el-input>
        </el-form-item>
      </el-form>
      <el-form :model="form" :rules="rules" ref="form" label-width="100px" :inline="true">
        <el-form-item label="状态">
          <el-select v-model="form.status" placeholder="请选择">
            <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.label">
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm()">提 交</el-button>
        <el-button @click="show = false">取 消</el-button>
      </span>
    </el-dialog>


  </div>
</template>


<script>
  export default {
    name: 'LeaseAgreement',
    data() {
      return {

        queryForm: {
          name: '',
          pageNum: 1,
          pageSize: 10
        },
        tableData: [],
        total: 0,
        show: false,
        showpoint: false,
        title: 'title',
        disabled: false,
        form: {
          name: '',
          text: '',
          status: '',
        },
        dialogType: 'add',
        options: [{
          value: '选项1',
          label: '有效'
        }, {
          value: '选项2',
          label: '失效'
        }],
        rules: {},

      }
    },
    methods: {
      query() {
        console.info(this.queryForm.name),
          this.$axios({
            method: 'post',
            url: 'api/lease/agreement/list',
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
      submitForm() {
        if (this.dialogType == 'add') {
          this.$axios({
            method: 'post',
            url: 'api/lease/agreement/add',
            data: this.form,
          }).then(res => {
            if (res.data.success) {
              this.show = false;
              this.query();
              console.info(this.form);
            } else {
              this.$message.error(res.data.msg);
            }
          }).catch(err => {
            console.info(err)
          });
        } else {
          this.$axios({
            method: 'post',
            url: 'api/lease/agreement/edit',
            data: this.form,
          }).then(res => {
            if (res.data.success) {
              this.show = false;
              this.query();
            } else {
              this.$message.error(res.data.msg);
            }
          }).catch(err => {
            console.info(err)
          });
        }
      },
      openAdd() {
        this.form = {};
        this.title = '新增';
        this.show = true;
        this.dialogType = 'add';
      },
      openEdit(row) {
        this.dialogType = 'edit';
        this.show = true;
        this.title = "编辑";
        this.form = Object.assign({}, row);
      },
      del(row) {
        this.$axios({
          method: 'get',
          url: 'api/lease/agreement/del/' + row.id
        }).then(res => {
          //刷新页面
          this.query()
        }).catch(err => {
          console.info(err)
        });
      },

    },
    created() {
      this.query();

    }

  }
</script>

<style>
</style>
