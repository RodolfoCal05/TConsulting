<template>
  <div>
    <div class="card">
      <div class="card-body col-sm-12">
        <button :class="buttonClass('btn-primary')">
          <i class="fas fa-file"></i> Nuevo
        </button>
        <button
          :class="buttonClass('btn-primary')"
          @click="guardar"
          v-if="gestion.estado == 'SOLICITADO'"
        >
          <i class="fas fa-save"></i> Guardar
        </button>
        <button
          :class="buttonClass('btn-primary')"
          @click="finalizar"
          v-if="gestion.estado == 'SOLICITADO' && gestion.id != 0"
        >
          <i class="fas fa-copy"></i> Finalizar
        </button>
        <button
          :class="buttonClass('btn-primary')"
          @click="finalizar"
          v-if="gestion.estado == 'ENVIADO'"
        >
          <i class="fas fa-satellite-dish"></i> Recibir
        </button>
      </div>
    </div>
    <div class="form-row">
      <div class="form-group col-sm-12">
        <label>Sucursal</label>
        <multiselect
          v-model="gestion.sucursal_origen"
          :allow-empty="false"
          :options="sucursales"
          :close-on-select="true"
          :show-labels="false"
          label="descripcion"
          @input="buscarSeries"
          placeholder="Seleccione una Sucursal"
        ></multiselect>
      </div>
    </div>
    <div class="form-row">
      <div class="form-group col-sm-3">
        <label>Id Gestion</label>
        <input class="form-control" type="text" v-model="gestion.id" disabled />
      </div>
      <div class="form-group col-sm-3">
        <label>Fecha</label>
        <input class="form-control" type="date" v-model="gestion.fecha" />
      </div>
      <div class="form-group col-sm-3">
        <label>Serie</label>
        <multiselect
          v-model="gestion.serie"
          :allow-empty="false"
          :options="series"
          :close-on-select="true"
          :show-labels="false"
          label="descripcion"
          placeholder=""
        ></multiselect>
      </div>
      <div class="form-group col-sm-3">
        <label>Destino</label>
        <multiselect
          v-model="gestion.sucursal_destino"
          :allow-empty="false"
          :options="sucursales"
          :close-on-select="true"
          :show-labels="false"
          label="descripcion"
          placeholder="Seleccione una Sucursal"
        ></multiselect>
      </div>
    </div>
    <div class="form-row">
      <div class="form-group col-sm-3">
        <label>Socio</label>
        <multiselect
          v-model="gestion.socio"
          :allow-empty="false"
          :options="socios"
          :close-on-select="true"
          :show-labels="false"
          label="nombre"
          placeholder=""
        ></multiselect>
      </div>
      <div class="form-group col-sm-3">
        <label>Tipo de Pago</label>
        <multiselect
          v-model="gestion.tipopago"
          :allow-empty="false"
          :options="tipoPagos"
          :close-on-select="true"
          :show-labels="false"
          label="descripcion"
          placeholder=""
        ></multiselect>
      </div>
      <div class="form-group col-sm-3">
        <label>Estado</label>
        <input
          class="form-control"
          type="text"
          v-model="gestion.estado"
          disabled
        />
      </div>
      <div class="form-group col-sm-3">
        <label>Observaciones</label>
        <textarea
          v-model="gestion.observaciones"
          row="3"
          class="form-control"
          aria-label="With textarea"
        ></textarea>
      </div>
    </div>
    <div class="form-row" v-if="gestion.serie">
      <div class="form-row col-sm-3">
        <table class="table table-striped">
          <tbody>
            <tr class="table-info">
              <td>Producto</td>
              <td>
                <input
                  class="form-control"
                  type="text"
                  v-model="form.producto_id"
                  @keydown.enter="buscarProducto"
                />
              </td>
            </tr>
            <tr class="table-info">
              <td>Nombre</td>
              <td>
                <input
                  class="form-control"
                  type="text"
                  v-model="form.producto.descripcion"
                />
              </td>
            </tr>
            <tr class="table-info">
              <td>Cantidad</td>
              <td>
                <input
                  class="form-control"
                  type="text"
                  v-model="form.cantidad"
                />
              </td>
            </tr>
            <tr class="table-info">
              <td>Existencias</td>
              <td>
                <input
                  class="form-control"
                  type="text"
                  v-model="form.existencias"
                />
              </td>
            </tr>
            <tr class="table-info">
              <td>Fecha Vencimiento</td>
              <td>
                <input
                  class="form-control"
                  type="text"
                  v-model="form.lote.descripcion"
                />
              </td>
            </tr>
            <tr class="table-info">
              <td>Precio</td>
              <td>
                <input class="form-control" type="text" v-model="precio" />
              </td>
            </tr>
            <tr class="table-info">
              <td>Descuento</td>
              <td>
                <input class="form-control" type="text" v-model="oferta" />
              </td>
            </tr>
            <tr>
              <td>
                <button
                  type="button"
                  class="btn btn-secondary btn-lg btn-block"
                  @click="agregarDetalle"
                >
                  Agregar
                </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      <div class="form-row col-sm-9">
        <table class="table table-striped">
          <thead class="thead-dark">
            <tr>
              <th>Id Producto</th>
              <th>Nombre Producto</th>
              <th>Cantidad</th>
              <th>Precio</th>
              <th>Descuento</th>
              <th>Estado</th>
              <th>Anular</th>
              <th>Eliminar</th>
            </tr>
          </thead>
          <tbody>
            <Detalles
              @borrar="borrarDetalle"
              v-for="(detalle, i) in gestion.detalles"
              :detalle="detalle"
              :key="i"
              :i="i"
              :serie="gestion.serie"
              :sede_id="gestion.tipo_sede_id"
              @anular="anularLinea"
            />
          </tbody>
        </table>
        <small
          class="text-danger"
          v-if="
            validationErrors['gestion.detalles'] && gestion.detalles.length == 0
          "
          >al menos un detalle es requerido</small
        >
      </div>
    </div>
  </div>
</template>

<script>
import Multiselect from "vue-multiselect";
import { errorsMixin } from "@/mixins/errors.js";
import Swal from "sweetalert2";
import Detalles from "./suministros-gestiones-detalles.vue";

export default {
  props: ["id"],
  components: {
    Multiselect,
    Detalles,
  },
  data() {
    return {
      sucursales: null,
      gestion: null,
      socios: null,
      tipoPagos: null,
      series: [],
      validationErrors: {
        gestion: null,
      },
      form: {
        producto_id: null,
        existencias: 0,
        reservado: 0,
        lote: {
          descripcion: null,
        },
        producto: {
          descripcion: null,
          precio: {
            precio_supermercado: null,
            precio_mayoreo: null,
            oferta: {
              id: null,
              valor: null,
            },
          },
        },
      },
    };
  },
  mounted() {
    const id = {
      opcion: "nuevaGestion",
      id: this.id,
    };

    axios
      .get(`/suministros/gestiones/${JSON.stringify(id)}/detail`)
      .then((res) => {
        this.sucursales = res.data.sucursales;
        this.gestion = res.data.gestion;
        this.socios = res.data.socios;
        this.tipoPagos = res.data.tipoPagos;
      })
      .catch((err) => {
        this.handleError(err);
      });
  },
  methods: {
    guardar() {
      if (this.gestion.serie.id == 3) {
        this.gestion.sucursal_destino = this.gestion.sucursal_origen;
        if (
          this.gestion.sucursal_destino.id == this.gestion.sucursal_origen.id ||
          !this.gestion.sucursal_destino
        ) {
          this.showToast("Debe cambiar el destino", "warning", 2000);
          return;
        }
      }

      if (this.gestion.serie.id == 1) {
        this.gestion.sucursal_destino = this.gestion.sucursal_origen;
        if (!this.gestion.socio) {
          this.showToast("Seleccione un socio", "warning", 2000);
          return;
        }

        if (this.gestion.tipopago.length == 0) {
          this.showToast("Seleccione un tipo de pago", "warning", 2000);
          return;
        }
      }

      axios
        .post("/suministros/gestiones/", {
          gestion: this.gestion,
        })
        .then((res) => {
          this.gestion = res.data;
          this.showToast("Gestion Guardada Correctamente");
        })
        .catch((err) => {
          this.handleError(err);
        });
    },
    buscarSeries(sucursal) {
      const id = {
        opcion: "series",
        sucursal_id: sucursal.id,
      };

      axios
        .get(`/suministros/gestiones/${JSON.stringify(id)}/detail`)
        .then((res) => {
          this.series = res.data;
        })
        .catch((err) => {
          this.handleError(err);
        });
    },
    buscarProducto() {
      if (!this.form.producto_id || this.form.producto_id == "") {
        this.showToast("Ingrese un producto", "warning", 2000);
        return;
      }

      const id = {
        opcion: "buscarProducto",
        producto_id: this.form.producto_id,
        sucursal_id: this.gestion.sucursal_origen.id,
        serie_id: this.gestion.serie.id,
      };

      axios
        .get(`/suministros/gestiones/${JSON.stringify(id)}/detail`)
        .then((res) => {
          this.form = res.data;
        })
        .catch((err) => {
          this.handleError(err);
        });
    },
    borrarDetalle(i) {
      this.gestion.detalles.splice(i, 1);
    },
    anularLinea(linea) {
      Swal.fire({
        title: "¿Esta seguro?",
        text: "¡No podra revertir esto!",
        icon: "warning",
        showCancelButton: true,
        CancelButtonText: "Cancelar",
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Si, anular linea!",
      }).then((result) => {
        if (!result.isConfirmed) {
          return;
        }
        const id = this.gestion.detalles[linea].id;

        axios
          .put("/suministros/gestiones/" + id)
          .then((res) => {
            this.gestion = res.data;
          })
          .catch((err) => {
            this.handleError(err);
          });
      });
    },
    agregarDetalle: function () {
      if (
        this.form.cantidad == "" ||
        this.form.cantidad == null ||
        this.form.cantidad == 0
      ) {
        Swal.fire({
          text: "Por favor ingresar la cantidad, no puede ir con valor vacio o valor 0",
          icon: "warning",
        });
        return;
      }

      this.gestion.detalles.forEach((element) => {
        if (element.producto_id == this.form.producto_id) {
          this.showToast("Ya existe el producto", "warning");

          return;
        }
      });

      const precio = this.form.producto.precio.precio_supermercado;

      if (this.gestion.tipo_sede_id == 2) {
        precio = this.form.producto.precio.precio_mayoreo;
      }

      this.gestion.detalles.push({
        gestion_id: null,
        producto_id: this.form.producto_id,
        producto: this.form.producto,
        cantidad: this.form.cantidad,
        costo: precio,
        // precio: this.form.precio,
        estado: "SOLICITADO",
        descuento: this.form.producto.precio.oferta.valor,
      });

      this.limpiarForm();
    },
    limpiarForm() {
      this.form = {
        producto_id: null,
        existencias: 0,
        reservado: 0,
        lote: {
          descripcion: null,
        },
        producto: {
          descripcion: null,
          precio: {
            precio_supermercado: null,
            precio_mayoreo: null,
            oferta: {
              id: null,
              valor: null,
            },
          },
        },
      };
    },
    finalizar() {
      const id = {
        opcion: "finalizar",
        id: this.gestion.id,
        serie_id: this.gestion.serie_id,
        origen: this.gestion.origen,
        destino: this.gestion.destino,
        estado: this.gestion.estado,
        detalles: this.gestion.detalles,
      };

      axios
        .get(`/suministros/gestiones/${JSON.stringify(id)}/detail`)
        .then((res) => {
          this.gestion = res.data;
          this.showToast("Gestion Finalizada Correctamente", "success", 2000);
        })
        .catch((err) => {
          this.handleError(err);
        });
    },
  },
  computed: {
    precio() {
      if (this.gestion.tipo_sede_id == 2) {
        return this.form.producto.precio.precio_mayoreo;
      }

      return this.form.producto.precio.precio_supermercado;
    },
    oferta() {
      if (this.form.producto.precio.oferta.id != 1) {
        return this.form.producto.precio.oferta.valor * 100 + " %";
      }

      return 0;
    },
  },
  mixins: [errorsMixin],
};
</script>

<style>
</style>
