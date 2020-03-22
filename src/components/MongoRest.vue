<template>
	<div id="cards">
		<div class="container-fluid">
			<b class="text-center">queried {{ entries.length }} elements</b>
		</div>
		<div class="card bg-highlight">
			<ul class="list-group">
				<li class="list-group-item bg-highlight" v-for="entry in entries" :key="entry.id">{{ entry.title }}</li>
			</ul>
		</div>
	</div>
</template>

<script lang="ts">
import Vue from 'vue';
import axios from 'axios';

export default Vue.extend({
	name: 'MongoRest',
	data() {
		return {
			entries: []
		}
	}, methods: {
		query(collection: string) {
			console.log('http://localhost:4000/?collection=' + collection + '&query="{}"')
			axios.get('http://localhost:4000/?collection=' + collection + '&query="{}"')
				.then((response) => {
					this.entries = response.data.slice(0, 10);
				}).catch((error) => {
					console.log(error);
				});
		}
	}, mounted: function () {
		this.$nextTick(function () {
			for (let collection of ['pearson_subscriptions'])
				this.query(collection);
		})
	}
});
</script>

<style scoped>
* {
	border-radius: 0 !important;
}

.bg-highlight {
	background-color: #2f353a;
	color: #e1e4e7;
}
</style>
