<template>
	<div id="cards">
		<div class="card bg-highlight" v-for="service in services" :key="service.name">
			<div class="card-header" :class="[ service.status ? 'green' : 'red' ]">
				<div class="container-fluid">
					<div class="row">
						<div class="col-sm">
						 <div>
							<div class="service-name">
								{{ service.name }}
							</div>
							<div class="service-ip">
								{{ service.ip }}
							</div>
						 </div>
						</div>
						<div class="col-sm text-center">
							<button class="btn">
								<svg v-if="!service.status" class="bi bi-play-fill" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									<path d="M11.596 8.697l-6.363 3.692c-.54.313-1.233-.066-1.233-.697V4.308c0-.63.692-1.01 1.233-.696l6.363 3.692a.802.802 0 010 1.393z"/>
								</svg>
								<svg v-if="service.status" class="bi bi-pause-fill" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									<path d="M5.5 3.5A1.5 1.5 0 017 5v6a1.5 1.5 0 01-3 0V5a1.5 1.5 0 011.5-1.5zm5 0A1.5 1.5 0 0112 5v6a1.5 1.5 0 01-3 0V5a1.5 1.5 0 011.5-1.5z"/>
								</svg>
						 </button>
						</div>
						<div class="col-sm">
							<button class="btn float-right">
								<svg class="bi bi-gear-fill" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
							<path fill-rule="evenodd" d="M9.405 1.05c-.413-1.4-2.397-1.4-2.81 0l-.1.34a1.464 1.464 0 01-2.105.872l-.31-.17c-1.283-.698-2.686.705-1.987 1.987l.169.311c.446.82.023 1.841-.872 2.105l-.34.1c-1.4.413-1.4 2.397 0 2.81l.34.1a1.464 1.464 0 01.872 2.105l-.17.31c-.698 1.283.705 2.686 1.987 1.987l.311-.169a1.464 1.464 0 012.105.872l.1.34c.413 1.4 2.397 1.4 2.81 0l.1-.34a1.464 1.464 0 012.105-.872l.31.17c1.283.698 2.686-.705 1.987-1.987l-.169-.311a1.464 1.464 0 01.872-2.105l.34-.1c1.4-.413 1.4-2.397 0-2.81l-.34-.1a1.464 1.464 0 01-.872-2.105l.17-.31c.698-1.283-.705-2.686-1.987-1.987l-.311.169a1.464 1.464 0 01-2.105-.872l-.1-.34zM8 10.93a2.929 2.929 0 100-5.86 2.929 2.929 0 000 5.858z" clip-rule="evenodd"/>
							</svg>
						 </button>
						</div>
					</div>
				</div>
			</div>
			<div class="card-body">
				<component v-bind:is="service.component"></component>
			</div>
		</div>
	</div>
</template>

<script lang="ts">
import Vue from 'vue';
import axios from 'axios';

import MongoRest from '@/components/MongoRest.vue'

export default Vue.extend({
	name: 'Pinger',
	data() {
		return {
			services: [
				{
					name: 'hort/daemon',
					ip: '127.0.0.1:4001',
					component: '',
					status: false,
					check: (service: Object) => {
						axios.get('http://localhost:4001/status')
							.then((response) => {
								service.status = true;
							}).catch((error) => {
								service.status = false;
							});
					}
				},
				{
					name: 'MongoREST',
					ip: '127.0.0.1:4000',
					component: 'MongoRest',
					status: false,
					check: (service: Object) => {
						axios.get('http://localhost:4000/status')
							.then((response) => {
								service.status = true;
							}).catch((error) => {
								service.status = false;
							});
					}
				},
				{
					name: 'Grafana',
					ip: '127.0.0.1:3000',
					component: '',
					status: false,
					check: (service: Object) => {
						axios.get('http://localhost:3000/api/health')
							.then((response) => {
								service.status = true;
							}).catch((error) => {
								service.status = false;
							});
					}
				},
				{
					name: 'Loki',
					ip: '127.0.0.1:3100',
					component: '',
					status: false,
					check: (service: Object) => {
						axios.get('http://localhost:3100/ready')
							.then((response) => {
								service.status = true;
							}).catch((error) => {
								service.status = false;
							});
					}
				},
				{
					name: 'Prometheus',
					ip: '127.0.0.1:9090',
					component: '',
					status: false,
					check: (service: Object) => {
						axios.get('http://localhost:9090/ready')
							.then((response) => {
								service.status = true;
							}).catch((error) => {
								service.status = false;
							});
					}
				}
			]
		}
	}, mounted: function() {
		this.$nextTick(function () {
			for (let service of this.services) {
				service.check(service);
			}
		});
	},
	components: {
		MongoRest
	}
});
</script>

<style scoped>
* {
	border-radius: 0 !important;
}

.red {
	background-color: #ac4142;
}

.green {
	background-color: #90a959;
}

.bg-highlight {
	background-color: #3a4149;
	color: #e1e4e7;
}

.service-name {
	font-weight: bold;
}

.service-ip {
	color: #282828;
	font-size: 10pt;
}

.card {
	margin: 15px;
}
</style>
