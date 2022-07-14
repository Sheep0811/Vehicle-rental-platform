<template>
	<div>
		<el-form :inline="true" :model="queryForm" style="text-align: left;">
      <el-form-item label="订单编号">
				<el-input v-model="queryForm.id" placeholder="订单编号"></el-input>
			</el-form-item>
      <el-form-item label="客户账号">
      	<el-input v-model="queryForm.id" placeholder="不可用"></el-input>
      </el-form-item>
      <el-form-item label="客户名称">
      	<el-input v-model="queryForm.id" placeholder="不可用"></el-input>
      </el-form-item>
      <el-form-item label="预定车型">
      	<el-input v-model="queryForm.id" placeholder="不可用"></el-input>
      </el-form-item>
			<el-form-item>
				<el-button type="primary" @click="query">查询</el-button>
			</el-form-item>
		</el-form>

		<el-table :data="tableData" style="width: 100%" :header-cell-style="{background:'#f7f7f7',color:'#666666'}">
			<el-table-column prop="id"  label="订单编号" width="100px">
			</el-table-column>
			<el-table-column prop="customerId" label="客户账号" width="100px">
			</el-table-column>
			<el-table-column prop="customerName" label="客户姓名" width="100px">
			</el-table-column>
			<el-table-column prop="carName" label="预定车型" width="100px">
			</el-table-column>
			<el-table-column prop="fromCity" label="取车城市" width="100px">
			</el-table-column>
			<el-table-column prop="fromShop" label="取车门店" width="100px">
			</el-table-column>
			<el-table-column prop="fromTime"  label="取车时间" width="100px">
			</el-table-column>
			<el-table-column prop="toCity" label="还车城市" width="100px">
			</el-table-column>
			<el-table-column prop="toShop" label="还车门店" width="100px">
			</el-table-column>
			<el-table-column prop="toTime" label="还车时间" width="100px">
			</el-table-column>
			<el-table-column prop="status" label="状态" width="100px">
			</el-table-column>
			<el-table-column prop="orderTime" label="订单日期" width="100px">
			</el-table-column>
			<el-table-column prop="agreementName" v-if="false" label="合同名称" width="100px">
			</el-table-column>
			<el-table-column prop="nomp" v-if="false" label="不计免赔险" width="100px">
			</el-table-column>
			<el-table-column prop="psur" v-if="false" label="车上人员责任险" width="100px">
			</el-table-column>
			<el-table-column prop="total" v-if="false" label="支付金额" width="100px">
			</el-table-column>
			<el-table-column fixed="right" label="详情">
				<template slot-scope="scope">
					<el-button type="text" size="small" @click="openMore(scope.row)">查看详情</el-button>
				</template>
			</el-table-column>
		</el-table>

		<!-- 分页 -->
		<el-pagination v-show="total > 0" background @size-change="query" @current-change="query"
			:current-page.sync="queryForm.pageNum" :page-size.sync="queryForm.pageSize"
			layout="total,sizes,prev, pager, next,jumper" :total="total">
		</el-pagination>

		<!-- 对话框 -->
		<el-dialog title="详细信息" :visible.sync="show" width="500px">
			<el-form :model="form" label-width="130px" :inline="true">
				<el-form-item label="订单编号" >
					<el-input v-model="form.id" clearable disabled="disabled"></el-input>
				</el-form-item>
				<el-form-item label="客户账号" >
					<el-input v-model="form.customerId" clearable disabled="disabled"></el-input>
				</el-form-item>
				<el-form-item label="客户姓名" >
					<el-input v-model="form.customerName" clearable disabled="disabled"></el-input>
				</el-form-item>
				<el-form-item label="预定车型" >
					<el-input v-model="form.carName" clearable disabled="disabled"></el-input>
				</el-form-item>
				<el-form-item label="取车城市">
					<el-input v-model="form.fromCity" clearable disabled="disabled"></el-input>
				</el-form-item>
				<el-form-item label="取车门店">
					<el-input v-model="form.fromShop" clearable disabled="disabled"></el-input>
				</el-form-item>
				<el-form-item label="取车时间">
					<el-input v-model="form.fromTime" clearable disabled="disabled"></el-input>
				</el-form-item>
				<el-form-item label="还车城市" >
					<el-input v-model="form.toCity" clearable disabled="disabled"></el-input>
				</el-form-item>
				<el-form-item label="还车门店" >
					<el-input v-model="form.toShop" clearable disabled="disabled"></el-input>
				</el-form-item>
				<el-form-item label="还车时间" >
					<el-input v-model="form.toTime" clearable  disabled="disabled"></el-input>
				</el-form-item>
				<el-form-item label="状态" >
					<el-input v-model="form.status" clearable disabled="disabled"></el-input>
				</el-form-item>
				<el-form-item label="订单日期">
					<el-input v-model="form.orderTime" clearable disabled="disabled"></el-input>
				</el-form-item>
				<el-form-item label="合同名称">
					<el-input v-model="form.agreementName" clearable disabled="disabled"></el-input>
				</el-form-item>
				<el-form-item label="不计免赔险">
					<el-input v-model="form.nomp" clearable disabled="disabled"></el-input>
				</el-form-item>
				<el-form-item label="车上人员责任险">
					<el-input v-model="form.psur" clearable disabled="disabled"></el-input>
				</el-form-item>
				<el-form-item label="支付金额">
					<el-input v-model="form.total" clearable disabled="disabled"></el-input>
				</el-form-item>
			</el-form>
			<span slot="footer" class="dialog-footer">
				<el-button @click="show = false">关闭</el-button>
			</span>
		</el-dialog>



	</div>
</template>

<script>
	export default {
		name: 'Agreement',
		data() {
			return {
				queryForm: {
					id: '',
					pageNum: 1,
					pageSize: 10,
				},
				//数据表格数组
				tableData: [],
				//一共多少条数据
				total: 0,

				show: false,

				form: {

				},
				options: [{
				          value: '选项1',
				          label: '有效'
				        }, {
				          value: '选项2',
				          label: '失效'
				        }],


				rules: {

				},

			}
		},

		methods: {
			query() {
				this.$axios({
					method: 'post',
					url: 'api/lease/order/list',
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

            openMore(row){
				this.form = Object.assign({}, row);
				this.show=true;
				console.info("forbid");

			},
		},

		created() {
			this.query();
		}
	}
</script>


<style>
	.el-input {
		width: 100%;
	}
</style>
