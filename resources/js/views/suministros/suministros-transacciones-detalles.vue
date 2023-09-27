<template>
  <tr>
    <th>{{ gestion.id }}</th>
    <td>{{ gestion.usuario.name }}</td>
    <td>{{ gestion.serie.descripcion }}</td>
    <td>{{ gestion.socio.nombre }}</td>
    <td>{{ gestion.estado }}</td>
    <td>{{ gestion.fecha }}</td>
    <td>{{ gestion.sucursal_origen.descripcion }}</td>
    <td>{{ gestion.sucursal_destino.descripcion }}</td>
    <td>
      <div class="form-inline col-sm-1">
        <button @click="abrirVentana()" class="btn btn-info">
          <i class="fas fa-eye"></i>
        </button>
      </div>
    </td>
  </tr>
</template>

<script>
import Multiselect from "vue-multiselect";
import { errorsMixin } from "@/mixins/errors.js";
export default {
  props: ["gestion"],
  mixins: [errorsMixin],
  components: {
    Multiselect,
  },
  methods: {
    abrirVentana() {
      window.open(
        `${window.location.protocol}//${window.location.host}/suministros/gestiones/${this.gestion.id}/edit/`
      );
    },

  },
};
</script>
