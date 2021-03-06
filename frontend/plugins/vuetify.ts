import Vue from 'vue';
import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css';
import 'material-design-icons-iconfont/dist/material-design-icons.css';

Vue.use(Vuetify);

export const vuetify = new Vuetify({
  icons: {
    iconfont: 'md'
  }
})

export interface VForm {
  validate:        () => boolean;
  reset:           () => void;
  resetValidation: () => void;
}
