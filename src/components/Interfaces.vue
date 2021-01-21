<template>
  <div class="container-fluid fill">
    <div class="row">
      <div class="col-sm">
        Logs
        <div class="h-100 logs">
          Foobar
        </div>
      </div>
      <div class="col-sm" >
        <div class="h-100 interfaces" :key = "rerender" >
          <div class="interface"
              v-for= "i in interfaces"
              v-on:click="select(i.name)"
              v-bind:key="i.name"
              :class="[ i.selected ? 'selected' : 'bg-highlight' ]" >
            {{ i.name }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from 'vue';
import axios from 'axios';

export default Vue.extend({
    name: 'Interfaces',
    data() {
        return {
            interfaces: {},
            rerender: 0,
            selected: {},
        }
    }, mounted: function() {
        this.$nextTick(function() {
            this.load();
        });
    },
    methods: {
        select: function(i) {
            this.selected = this.interfaces[i];
            for (let i_ in this.interfaces) {
                this.interfaces[i_]['selected'] = (this.interfaces[i_]["name"] == i);
            }
            this.rerender = !this.rerender;
        },
        load: function() {
            axios.get("http://localhost:9010/config")
                .then(response => {
                    response.data["message"]["interfaces"].map(i => this.interfaces[i["name"]] = {
                        "name": i["name"],
                        "capabilities": i["capabilities"],
                        "rules": i["rules"],
                        "selected": false,
                    });
                    this.rerender = !this.rerender;
                    console.log(this.interfaces);
                    console.log(response.data);
                })
                .catch(error => {
                    console.log(error);
                });
        }
    },
});
</script>

<style scoped>
* {
  border-radius: 0!important;
}

.fill {
  min-height: 100%;
  height: 100%;
}

.selected {
  background-color: #90a959;
}

.bg-highlight {
  background-color: #3a4149;
  color: #e1e4e7;
}

.foobar {
  height: 100 %;
  min-height: 100 %;
  max-height: 100 %;
}

.interface {
  font-weight: bold;
  padding: 10px;
  margin: 10px;

  -moz-user-select: none;
  -webkit-user-select: none;
  -ms-user-select: none;
  -o-user-select: none;
  user-select: none;
}

.logs {
  background-color: #23282c;
  color: #e1e4e7;
  min-height: 100%;
}
</style>
