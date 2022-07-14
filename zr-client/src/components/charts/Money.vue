<template>
	<div class="echart" id="mychart" :style="myChartStyle"></div>
</template>

<script>
	import * as echarts from "echarts";
	export default {
		data() {
			return {
				xData: ["奥迪A4L", "奥迪A6L", "奥迪Q5L", "奥迪e-tron", "奥迪Q3L", "奥迪Q7", "奥迪Q8L", "奥迪Q2L", "奥迪R8"], //横坐标
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
						type: 'category',
						data: ['2020-09-16', '2020-09-21', '2020-09-22','2020-09-23','2020-11-23','2021-10-09','2021-10-10','2021-10-13','2021-10-20']
					},
					yAxis: {
						type: 'value'
					},
					series: [{
						data: [3200,3500,2100,7650,3000,2750,11300,100,1100],
						type: 'line',
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
