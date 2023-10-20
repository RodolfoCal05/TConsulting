<template>
  <div>
    <div class="card">
      <div class="row">
        <div class="col-sm-6">
          <div class="card-header">
            <button
              type="submit"
              class="btn btn-success"
              @click="guardar('NUEVO')"
            >
              Guardar
            </button>
            <button
              type="submit"
              class="btn btn-danger"
              @click="guardar('ANULADO')"
              v-if="form.estado != 'GRABADO'"
            >
              Anular
            </button>
            <button type="submit" class="btn btn-primary" @click="clearForm">
              <i class="fas fa-broom"></i> Nueva Venta
            </button>
          </div>
          <div class="card-body">
            <div class="row">
              <div class="form-gorup col-sm-6">
                <label>Bodega</label>
                <input
                  type="text"
                  class="form-control"
                  v-model="form.bodega.descripcion"
                  readonly
                />
              </div>
            </div>
            <div class="row">
              <div class="form-group col-sm 6">
                <button
                  type="submit"
                  class="btn btn-primary btn-sm"
                  @click="buscarDisponible"
                >
                  <i class="fas fa-search"></i>
                </button>
                <label>CUE empleado</label>
                <multiselect
                  v-model="form.solicita"
                  :allow-empty="false"
                  :options="empleados"
                  :close-on-select="true"
                  :show-labels="false"
                  label="nombre_completo"
                  placeholder=""
                  @input="buscarDisponible"
                  :disabled="form.estado == 'REALIZADO'"
                ></multiselect>
              </div>
              <div class="form-group col-sm-6">
                <label>Tipo Pago</label>
                <multiselect
                  v-model="form.pago"
                  :allow-empty="false"
                  :options="tipoPagos"
                  :close-on-select="true"
                  :show-labels="false"
                  label="descripcion"
                  placeholder=""
                  :disabled="form.estado == 'REALIZADO'"
                ></multiselect>
              </div>
            </div>
            <div class="col-sm-12">
              <div class="align-center" style="max-width: 18rem">
                <div class="card-header align-self-center">
                  Monto Disponible
                </div>
                <div class="card-body" style="align-self-center">
                  <h5 class="card-title">Q.{{ montoDisponible }}</h5>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-sm-6">
          <div class="card-header">
            <div class="row">
              <div class="form group col-sm-4">
                <button
                  type="submit"
                  class="btn btn-primary btn-sm"
                  @click="buscarProducto"
                  :disabled="form.estado == 'REALIZADO'"
                >
                  <i class="fas fa-search"></i>
                </button>
                <label>Codigo Producto</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Ingrese Codigo"
                  v-model="formDetalle.producto.id"
                  @keydown.enter="buscarProducto()"
                  :disabled="form.estado == 'REALIZADO'"
                />
              </div>
              <div class="form-group col-sm-5">
                <label>Descripcion</label>
                <input
                  type="text"
                  class="form-control"
                  v-model="formDetalle.producto.descripcion"
                  readonly
                />
              </div>
              <div class="form-group col-sm-3">
                <label>Precio</label>
                <input
                  type="text"
                  class="form-control"
                  v-model="formDetalle.producto.precio"
                  readonly
                />
              </div>
            </div>
            <div class="row">
              <div class="form-group col-sm-4">
                <label>Existencia</label>
                <input
                  type="text"
                  class="form-control"
                  v-model="formDetalle.producto.existencias"
                  readonly
                />
              </div>
              <div class="form-group col-sm-4">
                <label>Cantidad</label>
                <input
                  type="number"
                  class="form-control"
                  v-model="formDetalle.cantidad"
                  :disabled="form.estado == 'REALIZADO'"
                />
              </div>
              <div class="form-group col-sm-1">
                <button
                  type="submit"
                  class="btn btn-primary btn-sm"
                  @click="agregarDetalle"
                >
                  <i class="fas fa-cart-plus"></i>
                </button>
              </div>
            </div>
          </div>
          <div class="card-body">
            <div
              class="form-group col-sm-12"
              style="height: 350px; overflow: scroll"
            >
              <table class="table">
                <thead>
                  <tr>
                    <th scope="col">Codigo</th>
                    <th scope="col">Nombre Producto</th>
                    <th scope="col">Cantidad</th>
                    <th scope="col">Precio</th>
                    <th scope="col">Quitar</th>
                  </tr>
                </thead>
                <tbody
                  v-for="(detalle, i) in form.detalles"
                  :detalle="detalle"
                  :key="i"
                  :i="i"
                >
                  <tr>
                    <td>{{ detalle.producto.id }}</td>
                    <td>{{ detalle.producto.descripcion }}</td>
                    <td>{{ parseFloat(detalle.cantidad).toFixed(2) }}</td>
                    <td>
                      Q. {{ parseFloat(detalle.producto.precio).toFixed(2) }}
                    </td>
                    <td>
                      <button
                        type="button"
                        class="btn btn-danger"
                        onclick="this.blur();"
                        @click.prevent="borrarDetalle(i)"
                        title="Borrar detalle"
                        :disabled="form.estado == 'REALIZADO'"
                      >
                        <i class="fas fa-trash-alt"></i>
                      </button>
                    </td>
                  </tr>
                </tbody>
                <tfoot>
                  <tr>
                    <td colspan="2"></td>
                    <td>Total Q.</td>
                    <td>{{ totalVenta }}</td>
                  </tr>
                </tfoot>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Multiselect from "vue-multiselect";
import { errorsMixin } from "@/mixins/errors.js";
import Swal from "sweetalert2";
export default {
  components: {
    Multiselect,
  },
  data() {
    return {
      form: {
        id: null,
        autoriza: [],
        solicita: [],
        producto: [],
        pago: [],
        bodega: [],
        estado: "GRABADO",
        detalles: [],
      },
      formDetalle: {
        producto: {
          id: null,
          descripcion: null,
          precio: null,
          existencias: null,
        },
        cantidad: null,
      },
      montoDisponible: null,
      tipoPagos: [],
      empleados: [],
      totalVenta: null,
      banderaAnulado: false,
    };
  },
  mounted() {
    const datos = { opcion: "inicio" };
    axios
      .get(`/abarroteria/venta/${JSON.stringify(datos)}/detail`)
      .then((response) => {
        console.log(response.data);
        this.tipoPagos = response.data.tipoPagos;
        this.empleados = response.data.empleados;
        this.form.bodega = response.data.bodega;
      })
      .catch((error) => this.HandleError(error));
  },
  computed: {},
  methods: {
    guardar(estado) {
      if (this.form.solicita.length == 0) {
        this.showToast("Seleccione Empleado", "error", 1500);
        return;
      }
      if (this.totalVenta > this.montoDisponible) {
        Swal.fire({
          text: "El empleado no cuenta con el Disponible Suficiente",
          icon: "warning",
        });
        return;
      }
      if (this.form.pago.length == 0) {
        this.showToast("Seleccione Tipo de Pago", "error", 1500);
        return;
      }
      if (this.form.detalles.length == 0) {
        this.showToast("Ingrese al menos un producto", "error", 1500);
        return;
      }

      if (estado == "NUEVO" && this.form.estado == "REALIZADO") {
        Swal.fire({
          text: "Venta ya grabada, Genere una nueva",
          icon: "warning",
        });
        return;
      }
      if (estado == "ANULADO" && this.banderaAnulado) {
        Swal.fire({
          text: "Venta ya Anulada, Genere una nueva",
          icon: "warning",
        });
        return;
      }
      if (estado == "ANULADO") {
        this.form.estado = estado;
      }

      axios
        .post("/abarroteria/venta", { form: this.form })
        .then((response) => {
          this.showToast("Venta Agregado Correctamente", "success", 1600);
          this.form.estado = response.data.estado;
          this.banderaAnulado = response.data.banderaAnulado;
        })
        .catch((error) => this.HandleError(error));
    },
    cancelar() {},
    buscarDisponible() {
      const datos = {
        opcion: "disponibleEmpleado",
        cue: this.form.solicita.cue,
      };
      axios
        .get(`/abarroteria/venta/${JSON.stringify(datos)}/detail`)
        .then((response) => {
          console.log(response.data);
          this.montoDisponible = parseInt(response.data);
        })
        .catch((error) => this.HandleError(error));
    },
    buscarProducto() {
      const datos = {
        opcion: "existenciaProducto",
        bodegaId: this.form.bodega.id,
        inventarioId: this.form.bodega.inventario_id,
        productoId: this.formDetalle.producto.id,
      };
      axios
        .get(`/abarroteria/venta/${JSON.stringify(datos)}/detail`)
        .then((response) => {
          console.log(response.data);
          this.formDetalle.producto = response.data[0];
        })
        .catch((error) => this.HandleError(error));
    },
    agregarDetalle() {
      if (this.formDetalle.producto.id == null) {
        this.showToast("Ingrese Codigo de producto", "error", 1500);
        return;
      }
      if (this.formDetalle.cantidad == null || this.formDetalle.cantidad == 0) {
        this.showToast("Ingrese Cantidad", "error", 1500);
        return;
      }
      if (this.formDetalle.cantidad > this.formDetalle.producto.existencias) {
        this.showToast("Existencia Insuficiente...", "error", 1500);
        return;
      }
      this.form.detalles.push(this.formDetalle);
      this.total(
        this.formDetalle.cantidad,
        this.formDetalle.producto.precio,
        "+"
      );
      this.clearFormDetalle();
    },
    borrarDetalle(i) {
      var datos = this.form.detalles[i];
      this.total(datos.cantidad, datos.producto.precio, "-");
      this.form.detalles.splice(i, 1);
    },
    total(cantidad, precio, operador) {
      if (operador == "+") {
        this.totalVenta += cantidad * precio;
      }
      if (operador == "-") {
        this.totalVenta -= cantidad * precio;
      }
    },
    clearForm() {
      this.form = {
        id: null,
        autoriza: [],
        solicita: [],
        producto: [],
        pago: [],
        bodega: this.form.bodega,
        estado: "GRABADO",
        detalles: [],
      };
      this.montoDisponible = null;
      this.totalVenta = null;
      this.clearFormDetalle();
    },
    clearFormDetalle() {
      this.formDetalle = {
        producto: {
          id: null,
          descripcion: null,
          precio: null,
          existencias: null,
        },
        cantidad: null,
      };
    },
  },
  mixins: [errorsMixin],
};
</script>

<style>
</style>