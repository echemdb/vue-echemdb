<template>
  <div>

    <!-- {{ csvs }} -->
    <remote-component
      url="https://unpkg.com/vue-plotly@^1/dist/vue-plotly.umd.min.js"
      :data="csvs"
      :layout="layout"
      :extract="library => library.Plotly" />
      <div v-for="trace in Object.keys(traces)" :key="trace">
      <input type="checkbox" :id="trace" :value="trace" v-model="selected" />{{ trace }}
    </div>
  </div>
</template>
<script lang="ts">
import { Component, Prop, Vue } from "vue-property-decorator";
import AsyncComputed from "vue-async-computed-decorator";
import RemoteComponent from "vue-remote-component";
import { parse, ParseResult } from 'papaparse';

@Component({
  components: { RemoteComponent },
})
export default class Compare extends Vue {
  @Prop({required: true, type: Object}) traces!: { [key: string]: string };

  layout = {
      xaxis: {
          title: {
              text: '<i>E</i> [V]',
              font: {
                  family: 'Courier New, monospace',
                  size: 18,
              }
          },
          showline: true,
          zeroline: false,
          ticks: "outside",
          mirror: true,
          side: "bottom"
      },
      yaxis: {
          title: {
              text: '<i>j</i> [A m⁻²]',
              font: {
                  family: 'Courier New, monospace',
                  size: 18,
              }
          },
          showline: true,
          zeroline: true,
          ticks: "outside",
          mirror: true,
          side: "left"
      },
      legend: {
          yanchor: "top",
          y: -0.3,
          xanchor: "left",
          x: 0.01
      }
  };

  selected: string[] = [];

  @AsyncComputed({default: []})
  async csvs() {
    let csvs: any[] = []

    for (let trace of this.selected) {
      parse(this.traces[trace].toString(), {
        download: true, 
        header: true,
        complete: function (results: ParseResult<Record<string, unknown>>){
          let x = [];
          let y: any[] = [];
          for (let row of results.data) {
            x.push(row["E"]);
            y.push(row["j"]);
          
          }
          csvs.push({x: x, y: y, type: "scatter"})
        }
        })

    }
    return csvs

  }
}
</script>
