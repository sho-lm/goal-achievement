<template lang="pug">
  .date-picker(
    :style="{ 'grid-template-columns': columns }"
  )
    v-btn.ma-auto(
      v-if="showArrow"
      icon
      @click="prev"
    )
      v-icon chevron_left
    v-menu(
      v-model="menu"
      :close-on-content-click="false"
      :attach="attach"
      max-width="290px"
      min-width="290px"
      :nudge-left="nudgeLeft"
      nudge-bottom="35"
    )
      template(v-slot:activator="{ on }")
        v-text-field.date-text(
          :value="date.format(textFormat)"
          v-on="on"
          dense
          hide-details
          readonly
        )
          template(v-slot:prepend-inner)
            v-btn(
              v-on="on"
              icon
              color="primary"
            )
              v-icon today
      v-date-picker(
        :type="type"
        v-model="pickerDate"
        :day-format="dayFormat"
        locale="ja"
      )
    v-btn.ma-auto(
      v-if="showArrow"
      icon
      @click="next"
    )
      v-icon chevron_right
</template>

<script lang="ts">
import Vue from 'vue';
import moment, { Moment } from 'moment';

moment.locale('ja');

export type DataType = {
  menu:       boolean
}

export default Vue.extend({
  props: {
    type:      { type: String,  default: 'date' },
    date:      { type: moment , default: moment() },
    isAttach:  { type: Boolean, default: false },
    showArrow: { type: Boolean, default: false },
  },
  data(): DataType {
    return {
      menu: false,
    }
  },
  computed: {
    pickerDate: {
      get(): string { return this.date.format(this.momentFormat); },
      set(newValue: string): void {
        const newDate = moment(newValue);
        if (newDate.isValid()) {
          this.emit(newDate);
          this.menu = false;
        }
      }
    },
    columns(): string {
      const dateWidth = this.type === 'month' ? '140px' : '200px';
      return this.showArrow ? `50px ${dateWidth} 50px` : dateWidth;
    },
    textFormat(): string {
      return this.type === 'month' ? 'YYYY年M月' : 'YYYY年M月D日(ddd)';
    },
    momentFormat(): string {
      return this.type === 'month' ? 'YYYY-MM' : 'YYYY-MM-DD';
    },
    attach(): string | boolean {
      return this.isAttach ? '.date-picker' : false;
    },
    nudgeLeft(): string {
      return this.type === 'month' ? '75' : '45';
    }
  },
  methods: {
    dayFormat(dateString: string): string {
      return moment(dateString).format('D');
    },
    emit(date: Moment): void {
      this.$emit('update:date', date);
    },
    prev(): void {
      const prev = moment(this.date);
      if (this.type === 'month') {
        prev.subtract(1, 'M');
      } else {
        prev.subtract(1, 'd');
      }
      this.emit(prev);
    },
    next(): void {
      const next = moment(this.date)
      if (this.type === 'month' ) {
        next.add(1, 'M');
      } else {
        next.add(1, 'd');
      }
      this.emit(next);
    },
  }
})
</script>

<style lang="scss" scoped>
  .date-picker {
    display: grid;
    height: 100%;

    .date-text {
      /deep/ input:hover {
        cursor: pointer;
      }
    }
  }
</style>
