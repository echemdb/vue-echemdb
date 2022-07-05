<template>
  <div>
    <div v-for="trace in Object.keys(traces)" :key="trace">
      <input type="checkbox" :id="trace" :value="trace" v-model="selected" />{{ trace }}
    </div>
    <!-- {{ csvs }} -->
    <remote-component
      url="https://unpkg.com/vue-plotly@^1/dist/vue-plotly.umd.min.js"
      :data="[{ x: [0, 1, 2, 3], y: [1, 3, 3, selected.length], type: 'scatter' }]"
      :extract="library => library.Plotly" />
  </div>
</template>
<script lang="ts">
import { Component, Prop, Vue } from "vue-property-decorator";
import axios from "axios";
import AsyncComputed from "vue-async-computed-decorator";
import RemoteComponent from "vue-remote-component";

@Component({
  components: { RemoteComponent },
})
export default class Compare extends Vue {
  @Prop({required: true, type: Object}) traces!: { [key: string]: string };

  selected: string[] = [];

  @AsyncComputed({default: []})
  async csvs() {
    let csvs = [];
    for (let trace of this.selected) {
      const raw = (await axios.get(this.traces[trace])).data;
      csvs.push(raw);
    }
    return csvs
  }
}
</script>
