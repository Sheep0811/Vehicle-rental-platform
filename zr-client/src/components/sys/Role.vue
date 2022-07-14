<template>
  <div>
    <!-- 查询条件 -->
    <el-form :inline="true" :model="queryForm" style="text-align: left">
      <el-form-item label="角色名称">
        <el-input v-model="queryForm.name" placeholder="请输入"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="query">查询</el-button>
        <el-button type="primary" @click="openAdd" plain>新增</el-button>
      </el-form-item>
    </el-form>
    <!-- 数据列表 -->
    <el-table
      :data="tableData"
      style="width: 100%"
      :header-cell-style="{ background: '#f7f7f7', color: '#666666' }"
    >
      <el-table-column prop="name" label="角色名称" align="center">
      </el-table-column>
      <el-table-column prop="mark" label="角色备注" align="center">
      </el-table-column>
      <el-table-column
        prop="authList"
        label="拥有权限"
        width="400px"
        align="center"
      >
        <template slot-scope="scope">
          <el-tag v-for="item in scope.row.authList" :key="item.id">{{
            item.name
          }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="createId" label="新增人员" align="center">
      </el-table-column>
      <el-table-column
        prop="modifyTime"
        label="更新时间"
        align="center"
        width="200px"
      >
      </el-table-column>
      <el-table-column fixed="right" label="操作" align="center">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="openEdit(scope.row)"
            >编辑</el-button
          >
          <el-popconfirm title="确定删除吗?" @confirm="del(scope.row)">
            <el-button slot="reference" type="text" size="small"
              >删除</el-button
            >
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页 -->
    <el-pagination
      v-show="total > 0"
      background
      @size-change="query"
      @current-change="query"
      :current-page.sync="queryForm.pageNum"
      :page-size.sync="queryForm.pageSize"
      layout="total,sizes,prev, pager, next,jumper"
      :total="total"
    >
    </el-pagination>
    <!-- 新增/修改页面 -->
    <el-dialog :title="title" :visible.sync="show" width="500px">
      <el-input type="hidden" :name="dialogType"></el-input>
      <el-form :model="form" :rules="rules" ref="form" label-width="80px">
        <el-form-item label="角色名称" prop="name">
          <el-input v-model="form.name" clearable></el-input>
        </el-form-item>
        <el-form-item label="角色备注" prop="mark">
          <el-input v-model="form.mark" clearable></el-input>
        </el-form-item>
        <el-form-item label="权限">
          <el-tree
            ref="tree"
            :data="list"
            show-checkbox
            node-key="id"
            :default-expanded-keys="roleauthlist"
            :default-checked-keys="roleauthlist"
            :props="defaultProps"
            @check-change="handleCheckChange"
          >
          </el-tree>
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
  name: "Role",
  data() {
    return {
      //查询条件对象
      queryForm: {
        name: "",
        pageNum: 1,
        pageSize: 10,
      },
      defaultProps: {
        children: "children",
        label: "name",
      },
      //数据表格数组
      tableData: [],
      //一共多少条数据
      total: 0,
      //对话框标题
      title: "",
      //显示/隐藏对话框
      show: false,
      //初始化表单对象
      form: {},
      //初始化校验对象
      rules: {
        name: [
          {
            required: true,
            message: "请输入账号",
            trigger: "blur",
          },
        ],
        mark: [
          {
            required: true,
            message: "请输入姓名",
            trigger: "blur",
          },
        ],
      },
      //所有权限
      authList: [],
      list: [],
      roleauthlist: [],
      rolenumlist:[],
      nums: 0,
      //标识是新增还是修改
      dialogType: "add",
      //主键是否可以被编辑:默认可以编辑
      disabled: false,
    };
  },
  methods: {
    //查询数据
    query() {
      this.$axios({
        method: "post",
        url: "api/sys/role/selectList",
        data: this.queryForm,
      })
        .then((res) => {
          if (res.data.success) {
            this.tableData = res.data.obj.list;
            this.total = res.data.obj.total;
          } else {
            this.$message.error(res.data.msg);
          }
        })
        .catch((err) => {
          console.info(err);
        });
    },
    setCheckedKeys() {
        this.$refs.tree.setCheckedKeys(this.roleauthlist);
    },
    getCheckedKeys() {
      // 获取选中的子节点
      let checkedKeys = this.$refs.tree.getCheckedKeys();
      // 获取选中的父节点
      let hafCheckedKeys = this.$refs.tree.getHalfCheckedKeys();
      // 合并
      this.roleauthlist = checkedKeys.concat(hafCheckedKeys);
    },
     handleCheckChange(data, checked, indeterminate) {
      // 获取选中的子节点
      let checkedKeys = this.$refs.tree.getCheckedKeys();
      // 获取选中的父节点
      let hafCheckedKeys = this.$refs.tree.getHalfCheckedKeys();
      // 合并
      this.rolenumlist = checkedKeys.concat(hafCheckedKeys);
      console.log(this.rolenumlist);
      //获取所有选中的节点 end
    },
    listroleauth(row) {
      this.$axios({
        method: "post",
        url: "api/sys/role/listroleauth/" + row.id,
      })
        .then((res) => {
          this.roleauthlist = [];
          if (res.data.success) {
            let i = 0;
            while (res.data.obj[i]) {
              this.roleauthlist.push(res.data.obj[i++]);
            }
            this.rolenumlist=this.roleauthlist;
            console.log(this.rolenumlist);
            // this.$refs.tree.setCheckedKeys([]);
            // functionIdList.forEach((i) => {
            //   // 根据id 拿到 Tree 组件中的node的所有信息
            //   let node = this.$refs.tree.getNode(i);
            //   // node.isLeaf：判断当前节点是否为子节点
            //   if (node.isLeaf) {
            //     //如果是子节点，就把状态设置成选中
            //     this.$refs.tree.setChecked(node, true);
            //   } else {}
            // });
          } else {
            this.$message.error(res.data.msg);
          }
        })
        .catch((err) => {
          console.info(err);
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
      this.dialogType = "add";
      //获取所有角色数组
      this.queryRoleList();
      //清除表单校验结果
      this.roleauthlist = [];
      this.$nextTick(function () {
        this.$refs["form"].clearValidate();
      });
    },
    openEdit(row) {
      //设置对话框标题
      this.title = "编辑";
      //清空表单
      this.form = {};
      //主键不可以编辑
      this.disabled = true;
      //设置校验规则为不可校验密码
      //打开对话框
      this.show = true;
      //更改标识为新增
      this.dialogType = "edit";
      //获取所有角色数组
      //this.listroleauth(row);
      this.queryRoleList();
      //对列表行对象进行克隆，解决双向绑定问题 注意：select 需要 @change="$forceUpdate()"强制刷新
      this.form = Object.assign({}, row);
      this.listroleauth(row);
      //console.log(this.roleauthlist.length);
      //console.log(this.list.length);
      this.$nextTick(function () {
        this.$refs["form"].clearValidate();
      });
    },
    insertroleauth(row) {
      this.$axios({
        method: "post",
        url: "api/sys/role/insertroleauth",
        data: {
          id: row.id,
          authnumList: this.roleauthlist,
        },
      })
        .then((res) => {})
        .catch((err) => {
          console.info(err);
        });
    },
    //更改状态
    change(row) {
      this.$confirm("确认要更改账号状态吗?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          this.$axios({
            method: "post",
            url: "api/sys/user/change",
            data: row,
          })
            .then((res) => {
              this.getList();
            })
            .catch((err) => {
              console.log(err);
            });
        })
        .catch(() => {
          if (row.status == "0") {
            row.status = "1";
          } else {
            row.status = "0";
          }
          this.$message({
            type: "info",
            message: "已取消操作",
          });
        });
    },
    submitForm() {
      this.$refs["form"].validate((valid) => {
        if (valid) {
          // getCheckedKeys();
          if (this.dialogType == "add") {
            this.$axios({
              method: "post",
              url: "api/sys/role/add",
              data: 
              {
                name: this.form.name,
                mark: this.form.mark,
                authnumList: this.rolenumlist,
              }
            })
              .then((res) => {
                //关闭对话框
                this.show = false;
                //insertroleauth(row);
                console.log(this.roleauthlist);
                //刷新页面
                this.query();
              })
              .catch((err) => {
                console.info(err);
              });
          } else {
            //getCheckedKeys();
            this.$axios({
              method: "post",
              url: "api/sys/role/edit",
              data: {
                id: this.form.id,
                name: this.form.name,
                mark: this.form.mark,
                authnumList: this.rolenumlist,
              },
            })
              .then((res) => {
                //关闭对话框
                //insertroleauth(row);
                this.show = false;
                //刷新页面
                this.query();
              })
              .catch((err) => {
                console.info(err);
              });
          }
        }
      });
    },
    del(row) {
      this.$axios({
        method: "get",
        url: "api/sys/role/del/" + row.id,
      })
        .then((res) => {
          //刷新页面
          this.query();
        })
        .catch((err) => {
          console.info(err);
        });
    },
    queryRoleList() {
      this.$axios({
        method: "post",
        url: "api/sys/auth/list",
        data: {
          name: "",
          pageNum: 1,
          pageSize: 100,
        },
      })
        .then((res) => {
          this.list = res.data.obj.list;
          this.nums = res.data.obj.total;
        })
        .catch((err) => {
          console.info(err);
        });
    },
  },
  created() {
    //初始化页面时进行数据查询
    this.query();
  },
};
</script>

<style>
.el-select {
  width: 100%;
}
</style>


