<template>
  <div>
    <!-- 查询条件 -->
    <el-form :inline="true" :model="queryForm" style="text-align: left;">
      <el-form-item label="车辆名称">
        <el-input v-model="queryForm.name" placeholder="车辆名称"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="query">查询</el-button>
        <el-button type="primary" @click="openAdd" plain>新增</el-button>
      </el-form-item>
    </el-form>
    <!-- 数据列表 -->
    <el-table :data="tableData" style="width: 100%" :header-cell-style="{background:'#f7f7f7',color:'#666666'}">
      <el-table-column prop="name" label="名称" width="100px" fixed="left">
      </el-table-column>
      <el-table-column prop="brand" label="品牌">
      </el-table-column>
      <el-table-column prop="model" label="型号">
      </el-table-column>
      <el-table-column prop="box" label="厢数">
      </el-table-column>
      <el-table-column prop="volume" label="排量">
      </el-table-column>
      <el-table-column prop="door" label="门数">
      </el-table-column>
      <el-table-column prop="seat" label="座数">
      </el-table-column>
      <el-table-column prop="gears" label="档位">
      </el-table-column>
      <el-table-column prop="auto" label="档位类型">
      </el-table-column>
      <el-table-column prop="price" label="价格(元/天)">
      </el-table-column>
      <el-table-column prop="status" label="状态">
      </el-table-column>
      <el-table-column prop="createId" label="新增人员">
      </el-table-column>
      <el-table-column prop="createTime" label="新增时间">
      </el-table-column>
      <el-table-column label="操作" min-width="280px" fixed="right">
        <template slot-scope="scope">
          <el-button type="primary" @click="openuoload(scope.row)" size="small" icon="el-icon-camera">图片
          </el-button>
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
    <!-- 新增/修改页面 -->
    <el-dialog :title="title" :visible.sync="show" width="500px">
      <el-input type="hidden" :name="dialogType"></el-input>
      <el-form :model="form" :rules="rules" ref="form">
        <el-form-item label="名称" prop="name">
          <el-input v-model="form.name" clearable></el-input>
        </el-form-item>
        <el-form-item label="品牌" prop="brand">
          <el-input v-model="form.brand" clearable></el-input>
        </el-form-item>
        <el-form-item label="型号" prop="model">
          <el-input v-model="form.model" clearable></el-input>
        </el-form-item>
        <el-form-item label="厢数" prop="box">
          <el-select v-model="form.box">
            <el-option label="2" value="2"></el-option>
            <el-option label="3" value="3"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="排量" prop="volume">
          <el-input v-model="form.volume" clearable></el-input>
        </el-form-item>
        <el-form-item label="门数" prop="door">
          <el-select v-model="form.door">
            <el-option label="2" value="2"></el-option>
            <el-option label="4" value="4"></el-option>
            <el-option label="5" value="5"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="座数" prop="seat">
          <el-select v-model="form.seat">
            <el-option label="2" value="2"></el-option>
            <el-option label="5" value="5"></el-option>
            <el-option label="6" value="6"></el-option>
            <el-option label="7" value="7"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="档位" prop="gears">
          <el-input v-model="form.gears" clearable></el-input>
        </el-form-item>
        <el-form-item label="档位类型" prop="auto">
          <el-select v-model="form.auto">
            <el-option label="自动" value="自动"></el-option>
            <el-option label="手动" value="手动"></el-option>
            <el-option label="一体" value="一体"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="价格(元/天)" prop="price">
          <el-input v-model.number="form.price" clearable></el-input>
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="form.status" prop="model">
            <el-option label="正常" value="正常"></el-option>
            <el-option label="下架" value="下架"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">提交</el-button>
        <el-button @click="show = false">取消</el-button>
      </span>
    </el-dialog>
    <!-- 图片 -->
    <el-dialog :title="title" :visible.sync="shows" width="500px">
      <el-input type="hidden" :name="picture"></el-input>
      <el-card>
        <el-image :src="imageUrl" fit="contain">
          <div slot="error" class="image-slot">
            <i class="el-icon-picture-outline"></i>
          </div>
        </el-image>
        <div style="padding: 14px;">
          <div class="bottom clearfix">
            <el-upload ref="upload" :action="action" :headers="headers" :on-remove="handleRemove" :limit="1"
              accept="image/jpeg" :before-upload="beforeUpload" :auto-upload="false" :on-success="uploadSuccess"
              :on-error="uploadError">
              <el-button slot="trigger" size="small" type="text">选取图片</el-button>
              <el-button style="margin-left: 10px;" size="small" type="text" @click="submitUpload">上传图片</el-button>
              <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过5MB</div>
            </el-upload>
          </div>
        </div>
      </el-card>
    </el-dialog>
  </div>
</template>

<script>
  export default {
    name: 'Car',
    data() {
      return {
        queryForm: {
          name: '',
          pageNum: 1,
          pageSize: 10
        },
        action: '/api/car/car/uploadImg',
        headers: {
          Token: this.$store.state.token
        },
        upData: {
          id: 0
        },
        //数据表格数组
        tableData: [],
        //一共多少条数据
        total: 0,
        //对话框标题
        title: '',
        //显示/隐藏对话框
        show: false,
        shows: false,
        //初始化表单对象
        form: {},
        dialogType: 'add',
        piclogType: 'picture',

        rules: {
          name: [{
            required: true,
            message: '请输入车辆名称',
            trigger: 'blur'
          }],
          brand: [{
            required: true,
            message: '请输入车辆品牌',
            trigger: 'blur'
          }],
          model: [{
            required: true,
            message: '请输入车辆型号',
            trigger: 'blur'
          }],
          price: [{
              required: true,
              message: '请输入价格',
              trigger: 'blur'
            },
            {
              type: 'number',
              message: '价格必须为数值',
              trigger: 'change'
            }
          ]
        }
      };
    },
    methods: {
      // 重置form表单
      query() {
        this.$axios({
          method: 'post',
          url: 'api/car/car/list',
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
            url: 'api/car/car/add',
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
            url: 'api/car/car/edit',
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

      del(row) {
        this.$axios({
          method: 'get',
          url: 'api/sys/auth/del/' + row.id
        }).then(res => {
          //刷新页面
          this.query()
        }).catch(err => {
          console.info(err)
        });
      },
      beforeUpload(file) {
        let types = ['image/jpeg'];
        const isImage = types.includes(file.type);
        const isLtSize = file.size / 1024 / 1024 < 5;
        if (!isImage) {
          this.$message({
            showClose: true,
            message: '上传图片只能是JPG格式!',
            type: 'error'
          });
          return false;
        }
        if (!isLtSize) {
          this.$message.error('上传图片大小不能超过 5MB!');
          return false;
        }
        return true;
      },
      submitUpload() {
        this.$refs.upload.submit();
      },
      handleRemove(file) {
        this.$refs.upload.clearFiles();
      },
      uploadSuccess(response, file, fileList) {
        if (response.success) {
          this.$store.commit('carImgUrl', response.obj);
        }
        this.$message({
          type: response.success ? "success" : "error",
          message: response.msg
        })
      },
      uploadError(err, file, fileList) {
        this.$message({
          showClose: true,
          message: err,
          type: 'error'
        });
      },
      openuoload(row) {
        this.piclogType = 'picture';
        this.shows = true;
        this.title = "图片";
        this.showpload = true;
        this.upData.id = row.id;
      },
    },
    computed: {
      imageUrl() {
        return 'data:image/jpeg;base64,' + this.$store.state.carImgUrl;
      }
    },
    created() {
      //页面加载查询车辆记录
      this.query();
    }
  }
</script>
<style>
  .el-select {
    width: 100%;
  }
</style>
