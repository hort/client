<template>
  <div id="cards">
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <input v-model="filter.key" type="text" class="form-control" placeholder="key">
        <select v-model="filter.rel" class="custom-select">
          <option value="eq" selected >=</option>
          <option value="deq">!=</option>
          <option value="like">*=</option>
        </select>
      </div>
      <input v-model="filter.val" type="text" class="form-control" placeholder="value">
      <button v-on:click="add_filters()" class="btn btn-primary" type="button">Button</button>
    </div>
    <div>
      {{ filters }}
      <!-- <div v-for="filter of filters" class="d-inline-block">
           { {{ filter.key }}: "{{ filter.val }}" }
           </div> -->
    </div>
  <div v-infinite-scroll="query" infinite-scroll-disabled="busy" infinite-scroll-distance="10">
    <json-tree :data="response"></json-tree>
  </div>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import axios from "axios";

import JsonTree from 'vue-json-tree'
Vue.component('json-tree', JsonTree)

export default Vue.extend({
  name: "Backend",
  data() {
    return {
      response: [],
      busy: false,
      filter: {
        key: "",
        rel: "",
        val: "",
      },
      filters: [],
      offset: 0,
      limit: 50,
    };
  },
  methods: {
    query() {
      this.busy = true;
      const collection = "pearson_subscriptions";
      axios.get("http://localhost:4000/mongo?collection=" + collection + '&query=' + JSON.stringify(this.filters) + `&limit=${this.limit}&offset=${this.offset}`)
        .then(response => {
          this.response = this.response.concat(response.data);
          this.offset += this.limit;
          this.busy = false;
        })
        .catch(error => {
          console.log(error);
        });
    },
    add_filters() {
      //this.filters[this.filter.key] = parseInt(this.filter.val);
      this.query();
    },
  },
  mounted: function() {
    this.$nextTick(function() {
      this.query();
    });
  },
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
