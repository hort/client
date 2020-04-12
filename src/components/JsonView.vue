<template>
  <div>
    <div v-if="isObject(data)" :style="{'margin-left': `${depth * 20}px`}">
      <svg v-if="expanded" @click="expanded = !expanded" class="bi bi-caret-down-fill" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        <path d="M7.247 11.14L2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 01.753 1.659l-4.796 5.48a1 1 0 01-1.506 0z"/>
      </svg>
      <svg v-if="!expanded" @click="expanded = !expanded" class="bi bi-caret-right-fill" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        <path d="M12.14 8.753l-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 011.659-.753l5.48 4.796a1 1 0 010 1.506z"/>
      </svg>
      {{ value }}
      <JsonView
        v-if="expanded"
        v-for="(child, k) in data"
        :data="child"
        :value="k"
        :depth="depth + 1"></JsonView>
    </div>
    <div v-else-if="isArray(data)" :style="{'margin-left': `${depth * 20}px`}">
      <svg v-if="expanded" @click="expanded = !expanded" class="bi bi-caret-down-fill" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        <path d="M7.247 11.14L2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 01.753 1.659l-4.796 5.48a1 1 0 01-1.506 0z"/>
      </svg>
      <svg v-if="!expanded" @click="expanded = !expanded" class="bi bi-caret-right-fill" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        <path d="M12.14 8.753l-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 011.659-.753l5.48 4.796a1 1 0 010 1.506z"/>
      </svg>
      {{ value }}
      <JsonView
        v-if="expanded"
        v-for="(child, i) in data"
        :data="child"
        :value="i"
        :depth="depth + 1"></JsonView>
    </div>
    <div v-else :style="{'margin-left': `${depth * 20}px`}">
      <div class="key float-left">{{ value }}:</div>
      <div class="overflow-hidden" :class="valueColor(data)">{{ data }}</div>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from 'vue';

export default Vue.extend({
  name: 'JsonView',
  props: [ 'data', 'value', 'depth' ],
  data() {
    return {
      expanded: false
    }
  },
  methods: {
    isObject(value: any) {
      return JSON.parse(JSON.stringify(value)).constructor === Object;
    },
    isArray(value: any) {
      return Array.isArray(JSON.parse(JSON.stringify(value)));
    },
    valueColor(value: any) {
      console.log(typeof value);
      switch (typeof value) {
        case 'number': return 'red';
        case 'string': return 'green';
        case 'boolean': return 'yellow';
      }
    }
  }
});
</script>

<style scoped>
.key {
  font-weight: bold;
  margin-right: 5px;
}

.blue {
  color: #6a9fb5;
}

.green {
  color: #90a959;
}

.yellow {
  color: #f4bf75;
}

.red {
  color: #ac4142;
}

</style>
