<template>
	<div class="echart" id="mychart" :style="myChartStyle"></div>
</template>

<script>
	import * as echarts from "echarts";
	export default {
		data() {
			return {
				xData: ["奥迪A4L", "奥迪A6L", "奥迪Q5L", "奥迪e-tron", "奥迪Q3L", "奥迪Q7", "奥迪Q8L","奥迪Q2L","奥迪R8"], //横坐标
				yData: [9, 4, 2, 1, 0, 0, 0, 0, 0], //数据
				myChartStyle: {
					float: "left",
					width: "100%",
					height: "400px"
				} //图表样式
			};
		},
		mounted() {
			this.initEcharts();
		},
		methods: {
			initEcharts() {
				// 基本柱状图
				const option = {
					xAxis: {
						data: this.xData
					},
					yAxis: {},
					series: [{
						type: "bar", //形状为柱状图
						data: this.yData,
						label: {
							// 柱状图上方文本标签，默认展示数值信息
							show: true,
				 		position: "top"
						}
					}]
				};
				const myChart = echarts.init(document.getElementById("mychart"));
				myChart.setOption(option);
				//随着屏幕大小调节图表
				window.addEventListener("resize", () => {
					myChart.resize();
				});
			}
		}
	};
</script>

<style>
</style>
