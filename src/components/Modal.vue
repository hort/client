<template>
  <div class="modal fade" v-bind:id="uniq" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content bg-dark">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
          <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
               </button> -->
        </div>
        <div class="modal-body">
          foo bar baz
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from 'vue';

export default Vue.extend({
  name: 'Modal',
  props: [ 'uniq' ],
  data() {
    return { }
  },
});

</script>

<style scoped>

</style>
