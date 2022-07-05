import Vue, { PluginFunction, VueConstructor } from 'vue';


interface InstallFunction extends PluginFunction<any> {
  installed?: boolean;
}

declare const VueEchemdb: { install: InstallFunction };
export default VueEchemdb;

export const VueEchemdbSample: VueConstructor<Vue>;
