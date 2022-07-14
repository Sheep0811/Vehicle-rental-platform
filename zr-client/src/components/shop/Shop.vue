<template>
  <div>
    <!-- 查询条件 -->
    <el-form :inline="true" :model="queryForm" style="text-align: left;">
      <el-form-item label="门店名称">
        <el-input v-model="queryForm.name" placeholder="门店名称"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="query">查询</el-button>
        <el-button type="primary" @click="openAdd" plain>新增</el-button>
      </el-form-item>
    </el-form>
    <!-- 数据列表 -->
    <el-table :data="tableData" style="width: 100%">
      <el-table-column prop="id" label="id" v-if="false"></el-table-column>
      <el-table-column prop="name2" label="省份名称">
      </el-table-column>
      <el-table-column prop="name1" label="城市名称">
      </el-table-column>
      <el-table-column prop="name" label="门店名称">
      </el-table-column>
      <el-table-column prop="address" label="门店地址">
      </el-table-column>
      <el-table-column prop="tel" label="电话">
      </el-table-column>
      <el-table-column prop="admin" label="负责人">
      </el-table-column>
      <el-table-column prop="status" label="状态">
      </el-table-column>
      <el-table-column prop="createId" label="新增人员">
      </el-table-column>
      <el-table-column prop="createTime" label="新增时间">
      </el-table-column>
      <el-table-column fixed="right" label="操作">
        <template slot-scope="scope">
          <el-button @click="openEdit(scope.row)" type="text" size="small">编辑</el-button>
          <el-popconfirm title="确定删除吗?" @confirm="del(scope.row)">
            <el-button slot="reference" type="text" size="small">删除</el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
      <!-- 分页 -->
    </el-table>
    <el-pagination v-show="total > 0" background @size-change="query" @current-change="query"
      :current-page.sync="queryForm.pageNum" :page-size.sync="queryForm.pageSize"
      layout="total,sizes,prev, pager, next,jumper" :total="total">
    </el-pagination>

    <el-dialog :title="title" :visible.sync="show" width="500px">
      <el-form ref="form" :model="form" :rules="rules" label-width="60px">
        <el-form-item label="省份" prop="provinceId">
          <el-select v-model="form.provinceId" placeholder="请选择" style="width: 100%" @change="$forceUpdate()">
            <el-option v-for="item in provinces" :key="item.id" :label="item.name" :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="城市" prop="cityId">
          <el-select v-model="form.cityId" placeholder="请选择" style="width: 100%" @change="$forceUpdate()">
            <el-option v-for="item in citys" :key="item.id" :label="item.name" :value="item.id" >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="门店" prop="name">
          <el-input v-model="form.name" clearable></el-input>
        </el-form-item>
        <el-form-item label="地址" prop="address">
          <el-input v-model="form.address" clearable></el-input>
        </el-form-item>
        <el-form-item label="电话" prop="tel">
          <el-input v-model="form.tel" clearable></el-input>
        </el-form-item>
        <el-form-item label="负责人" prop="admin">
          <el-input v-model="form.admin" clearable></el-input>
        </el-form-item>
        <el-form-item label="状态" prop="status" >
          <el-select v-model="form.status" placeholder="请选择" style="width: 100%" :disabled="disabled" @change="$forceUpdate()">
            <el-option v-for="(item,index) in S" :key="index" :label="item" :value="item">
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
    name: 'Shop',
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

        disabled: false,
        // 初始化表单对象
        form: {},
        // 初始化校验对象
        rules: {
          // status: [{
          //   required: true,
          //   message: '请输入角色名称',
          //   trigger: 'blur'
          // }],
        },
        provinces: {},
        citys: {},
        S:['在营','关闭'],
        I:0
      }
    },
    methods: {
      del(row)
      {
        this.$axios({
          method: 'get',
          url: 'api/shop/shop/del/' + row.id
        }).then(res => {
          //刷新页面
          this.query()
        }).catch(err => {
          console.info(err)
        });
      },
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
      getc()
      {
        this.$axios({
          method: "post",
          url: "api/shop/city/getc",
        }).then(res => {
          this.citys = res.data.obj;
          // console.info(this.citys)
        }).catch(err => {
          console.info(err)
        });
      },
      query() {
        this.$axios({
          method: 'post',
          url: 'api/shop/shop/list',
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
        this.getc()
        this.getp()
        this.title = "新增"
        this.form = {}
        this.show = true
        this.dialogType = "add"
        this.disabled=true
      },
      openEdit(row){
        this.title = "编辑"
        this.form = {}
        this.show = true
        this.disabled=false
        this.dialogType = "edit"
        this.form = Object.assign({}, row);
        for(let item of this.provinces)
        {
          if(item.name==row.name2)
          {
            this.form.provinceId=item.id
          }
        }
        console.log(this.form.provinceId)
        for(let item of this.citys)
        {
          if(item.name==row.name1)
          {
            this.form.cityId=item.id
          }
        }
        console.log(this.form.provinceId)
        this.form.status=row.status
      },
      submitForm() {
        this.$refs['form'].validate((valid) => {
          if (valid) {
            if (this.dialogType == 'add') {
              this.$axios({
                method: "post",
                url: "api/shop/shop/add",
                data: this.form
              }).then(res => {
                this.show = false
                this.query()
              }).catch(err => {
                console.info(err)
              });
            } else {
              this.$axios({
                method: "post",
                url: "api/shop/shop/edit",
                data: this.form
              }).then(res => {
                this.show = false
                this.query()
              }).catch(err => {
                console.info(err)
              });
            }
          }
        });
      },
    },
    created() {
      this.getc()
      this.getp()
      this.query()
    }
  }
</script>

<style>
</style>
