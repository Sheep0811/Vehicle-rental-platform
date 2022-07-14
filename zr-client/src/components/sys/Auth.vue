<template>
  <div>
    <!-- 查询条件 -->
    <el-form :inline="true" :model="queryForm" style="text-align: right">
      <el-form-item>
        <el-button type="primary" @click="openAdd" plain>新增</el-button>
      </el-form-item>
    </el-form>
    <!-- 数据列表 -->
    <el-table
      :data="tableData"
      style="width: 100%; margin-bottom: 20px"
      row-key="id"
      border
      default-expand-all
      :tree-props="{ children: 'children', hasChildren: 'hasChildren' }"
    >
      <el-table-column prop="id" label="权限编号"> </el-table-column>
      <el-table-column prop="name" label="权限名称"> </el-table-column>
      <el-table-column prop="url" label="访问地址"> </el-table-column>
      <el-table-column prop="mark" label="备注"> </el-table-column>
      <el-table-column prop="createId" label="新增者ID"> </el-table-column>
      <el-table-column prop="createTime" label="新增时间"> </el-table-column>
      <el-table-column prop="modifyId" label="修改者ID"> </el-table-column>
      <el-table-column prop="modifyTime" label="修改时间"> </el-table-column>
      <el-table-column fixed="right" label="操作">
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
        <el-form-item label="权限编号" prop="id">
          <el-input v-model="form.id" clearable :disabled="disabled"></el-input>
        </el-form-item>
        <el-form-item label="权限名称" prop="name">
          <el-input v-model="form.name" clearable></el-input>
        </el-form-item>
        <el-form-item label="访问地址" prop="url">
          <el-input v-model="form.url" type="url" clearable></el-input>
        </el-form-item>
        <el-form-item label="排序序号" prop="seq">
          <el-input v-model="form.seq" type="seq" clearable></el-input>
        </el-form-item>
        <el-form-item label="权限备注" prop="mark">
          <el-input v-model="form.mark" type="mark" clearable></el-input>
        </el-form-item>
        <el-form-item label="上级菜单">
          <el-select
            v-model="form.pid"
            placeholder="请选择"
            @change="$forceUpdate()"
          >
            <el-option
              v-for="item in fathernames"
              :key="item.id"
              :label="item.name"
              :value="item.id"
            >
            </el-option>
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
  name: "Auth",
  data() {
    return {
      queryForm: {
        name: "",
        pageNum: 1,
        pageSize: 20,
      },
      tableData: [],
      //一共多少条数据
      total: 0,
      //对话框标题
      title: "",
      //显示/隐藏对话框
      show: false,
      //初始化表单对象
      form: {},
      rules: {
        id: [
          {
            required: true,
            message: "请输入权限编号",
            trigger: "blur",
          },
        ],
        name: [
          {
            required: true,
            message: "请输入权限名称",
            trigger: "blur",
          },
        ],
        seq: [
          {
            required: true,
            message: "请输入排序序号",
            trigger: "blur",
          },
        ],
      },
      rules: {},
      dialogType: "add",
      fathernames: [],
      disabled: false,
    };
  },
  methods: {
    //查询数据
    query() {
      this.$axios({
        method: "post",
        url: "api/sys/auth/list",
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
      this.fatherquery();
      this.dialogType = "add";

      this.$nextTick(function () {
        this.$refs["form"].clearValidate();
      });
    },
    fatherquery() {
      this.$axios({
        method: "post",
        url: "api/sys/auth/father",
      })
        .then((res) => {
          this.fathernames = res.data.obj;
        })
        .catch((err) => {
          console.info(err);
        });
    },
    submitForm() {
      this.$refs["form"].validate((valid) => {
        if (valid) {
          if (this.dialogType == "add") {
            this.$axios({
              method: "post",
              url: "api/sys/auth/add",
              data: this.form,
            })
              .then((res) => {
                //关闭对话框
                this.show = false;
                //刷新页面
                this.query();
              })
              .catch((err) => {
                console.info(err);
              });
          } else {
            this.$axios({
              method: "post",
              url: "api/sys/auth/edit",
              data: this.form,
            })
              .then((res) => {
                //关闭对话框
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
      this.fatherquery();
      this.dialogType = "edit";
      this.form = Object.assign({}, row);

      this.$nextTick(function () {
        this.$refs["form"].clearValidate();
      });
    },
    del(row) {
      this.$axios({
        method: "get",
        url: "api/sys/auth/del/" + row.id,
      })
        .then((res) => {
          //刷新页面
          this.query();
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
</style>