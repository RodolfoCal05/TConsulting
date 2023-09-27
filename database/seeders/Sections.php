<?php
namespace Database\Seeders;

// new CsgtModule($aName, $aDescription, $aModule, $aMenuOrder, [$aIcon=null, $aParentModule=null, $aPermissions=CsgtModule::ALL, $aMenuPermission = 'index', $aLegacyModule])

class Sections
{
    public function get()
    {
        return collect([
            // Inicio
            new CsgtModule('Inicio', 'Inicio', 'index', 1, 'fa fa-home', null, CsgtModule::INDEX),

            //Recursos Humanos
            new CsgtModule('RRHH', 'RRHH', 'rrhh', 100, 'fas fa-building',  null, []),
            new CsgtModule('Empleados', 'RRHH - Empleados', 'rrhh.empleados', 150, 'fa fa-user', 'rrhh', ['index', 'edit', 'store', 'detail', 'update']),

            // Productos
            new CsgtModule('Productos', 'Productos', 'productos', 200, 'fas fa-pallet', null, []),
            new CsgtModule('Lista de Productos', 'Productos - Lista de Productos', 'productos.lista-productos', 10, 'fas fa-layer-group', 'productos'),
            new CsgtModule('Precios', 'Productos - Precios', 'productos.precios', 20, 'fas fa-dollar-sign', 'productos'),
            new CsgtModule('Ofertas', 'Productos - Ofertas', 'productos.ofertas', 30, 'fas fa-tag', 'productos'),
            new CsgtModule('Lotes', 'Productos - Lotes', 'productos.lotes', 40, 'fas fa-calendar-alt', 'productos'),

            // Inventarios
            new CsgtModule('Inventarios', 'Inventarios', 'inventarios', 300, 'fas fa-tasks', null, []),
            new CsgtModule('Sucursales', 'Inventarios - Sucursales', 'inventarios.sucursales', 10, 'fas fa-store', 'inventarios', ['index', 'update', 'edit', 'data', 'store', 'create']),
            new CsgtModule('Lote de Inventario', 'Inventarios - Lote de Inventario', 'inventarios.lote-inventario', 20, 'fas fa-calendar-check', 'inventarios', ['index', 'update', 'edit', 'data']),

            // Socios
            new CsgtModule('Socios', 'Socios', 'socios', 400, 'fas fa-handshake', null, []),
            new CsgtModule('Listado de Socios', 'Socios - Listado de Socios', 'socios.listado-socios', 10, 'fas fa-users', 'socios'),

            // Suministros
            new CsgtModule('Suministros', 'Suministros', 'suministros', 500, 'fas fa-shipping-fast', null, []),
            new CsgtModule('Transacciones', 'Suministros - Transacciones', 'suministros.transacciones', 5, 'fa fa-book', 'suministros', ['index', 'data']),
            new CsgtModule('Gestiones', 'Suministros - Gestiones', 'suministros.gestiones', 10, 'fas fa-file-signature', 'suministros', ['index', 'edit', 'store', 'detail']),

            //Catalogos
            new CsgtModule('Catálogos', '', 'catalogs', 2000, 'fa fa-book', null, []),
            new CsgtModule('Usuarios', 'Catálogos - Usuarios', 'catalogs.users', 100, 'fa fa-user', 'catalogs'),
            new CsgtModule('Roles', 'Catálogos - Roles', 'catalogs.roles', 200, 'fa fa-key', 'catalogs'),
            new CsgtModule('Control de Accesos', 'Catálogos - Control de Accesos', 'catalogs.control-accesos', 300, 'fas fa-user-cog', 'catalogs', ['index', 'detail', 'store']),

        ]);
    }
}