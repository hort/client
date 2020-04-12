<template>
  <div id="cards">
    <div class="bg-highlight">
      <JsonView
        class="root"
        :data="entries"
        :value="'query results'"
        :depth="0"
      ></JsonView>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import axios from "axios";

import JsonView from "@/components/JsonView.vue";

export default Vue.extend({
  name: "MongoRest",
  data() {
    return {
      entries: {},
      response: {}
    };
  },
  methods: {
    query(collection: string) {
      axios
        .get(
          "http://localhost:4000/mongo?collection=" + collection + '&query="{}"'
        )
        .then(response => {
          this.entries = response.data.slice(0, 10);
          this.response = response.data;
          console.log(response.data);
        })
        .catch(error => {
          console.log(error);
        });
    }
  },
  mounted: function() {
    this.$nextTick(function() {
      for (let collection of [])
        this.query(collection);
    });
  },
  components: {
    JsonView
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
