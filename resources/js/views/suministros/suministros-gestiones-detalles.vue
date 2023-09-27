<template>
  <tr>
    <td>{{ detalle.producto_id }}</td>
    <td>{{ detalle.producto.descripcion }}</td>
    <td>
      <input class="form-control" type="number" v-model="detalle.cantidad" />
    </td>
    <td>{{ precio }}</td>
    <td>{{ oferta }}</td>
    <td>{{ detalle.estado }}</td>
    <td>
      <button
        type="button"
        class="btn btn-danger"
        @click.prevent="anularLinea"
        onclick="this.blur();"
        title="Anular linea"
        :disabled="detalle.estado != 'FINALIZADO'"
      >
        <i class="fas fa-window-close"></i>
      </button>
    </td>
    <td>
      <button
        type="button"
        class="btn btn-danger"
        onclick="this.blur();"
        @click.prevent="borrarDetalle"
        title="Borrar detalle"
        :disabled="detalle.estado != 'SOLICITADO'"
      >
        <i class="fas fa-trash-alt"></i>
      </button>
    </td>
  </tr>
</template>

<script>
export default {
  props: ["detalle", "sede_id", "i"],
  data() {
    return {
      index: this.i,
    };
  },
  methods: {
    borrarDetalle() {
      this.$emit("borrar", this.index);
    },
    anularLinea() {
      this.$emit("anular", this.index);
    },
  },
  computed: {
    precio() {
      if (this.sede_id == 2) {
        return this.detalle.producto.precio.precio_mayoreo;
      }

      return this.detalle.producto.precio.precio_supermercado;
    },
    oferta() {
      if (this.detalle.producto.precio.oferta.id != 1) {
        return this.detalle.producto.precio.oferta.valor * 100 + " %";
      }

      return 0;
    },
  },
};
</script>

<style>
</style>
