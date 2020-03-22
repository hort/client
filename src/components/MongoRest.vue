<template>
	<div id="cards">
		<!--
		<div class="container-fluid">
			<p class="font-weight-bold">
				queried {{ response.length }} elements, showing first {{ entries.length }}
			</p>
		</div>
		<div class="card bg-highlight">
			<ul class="list-group">
				<li class="list-group-item bg-highlight" v-for="entry in entries" :key="entry.id">{{ entry.title }}</li>
			</ul>
		</div>
		-->
		<div class="bg-highlight">
			<JsonTree class="root"
				:data="entries"
				:value="'query results'"
				:depth="0"></JsonTree>
		</div>
	</div>
</template>

<script lang="ts">
import Vue from 'vue';
import axios from 'axios';

import JsonTree from '@/components/JsonTree.vue'

export default Vue.extend({
	name: 'MongoRest',
	data() {
		return {
			entries: {},
			response: {},
		}
	}, methods: {
		query(collection: string) {
			axios.get('http://localhost:4000/?collection=' + collection + '&query="{}"')
				.then((response) => {
					this.entries = response.data.slice(0, 10);
					// this.response = response.data;
					console.log(response.data);
				}).catch((error) => {
					console.log(error);
				});
		}
	}, mounted: function () {
		this.$nextTick(function () {
			for (let collection of ['pearson_subscriptions'])
				this.query(collection);
		})
	}, components: {
		JsonTree
	}
});
</script>

<style scoped>
* {
	border-radius: 0 !important;
}

.root {
	padding: 10px;
}

.bg-highlight {
	background-color: #2f353a;
	color: #e1e4e7;
}
</style>
