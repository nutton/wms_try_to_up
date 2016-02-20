--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: allocation_strategies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE allocation_strategies (
    id integer NOT NULL,
    name character varying(25) NOT NULL,
    code character varying(5) NOT NULL,
    description character varying(50),
    warehouse_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: allocation_strategies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE allocation_strategies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: allocation_strategies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE allocation_strategies_id_seq OWNED BY allocation_strategies.id;


--
-- Name: allocation_strategy_lines; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE allocation_strategy_lines (
    id integer NOT NULL,
    order_sequence integer NOT NULL,
    allocation_zone_id integer NOT NULL,
    containerization_method character varying(25) NOT NULL,
    minimum_pick_uom character varying(25) NOT NULL,
    containerization_level character varying(25) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    allocation_strategy_id integer NOT NULL
);


--
-- Name: allocation_strategy_lines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE allocation_strategy_lines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: allocation_strategy_lines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE allocation_strategy_lines_id_seq OWNED BY allocation_strategy_lines.id;


--
-- Name: allocation_strategy_rules; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE allocation_strategy_rules (
    id integer NOT NULL,
    warehouse_id integer NOT NULL,
    order_sequence integer NOT NULL,
    order_type_id integer,
    product_category_id integer,
    product_subcategory_id integer,
    allocation_strategy_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    customer_id integer,
    customer_type_id integer,
    product_status_id integer
);


--
-- Name: allocation_strategy_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE allocation_strategy_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: allocation_strategy_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE allocation_strategy_rules_id_seq OWNED BY allocation_strategy_rules.id;


--
-- Name: allocation_zones; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE allocation_zones (
    id integer NOT NULL,
    code character varying NOT NULL,
    name character varying NOT NULL,
    description character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    warehouse_id integer
);


--
-- Name: allocation_zones_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE allocation_zones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: allocation_zones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE allocation_zones_id_seq OWNED BY allocation_zones.id;


--
-- Name: assignment_details; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE assignment_details (
    id integer NOT NULL,
    assignment_id integer NOT NULL,
    expected_product_id integer,
    actual_product_id integer,
    expected_quantity integer,
    actual_quantity integer,
    from_container_id integer,
    to_container_id integer,
    start_time date,
    finish_time date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    start_location_type character varying(25),
    start_location_id integer,
    end_location_type character varying(25),
    end_location_id integer,
    wave_id integer
);


--
-- Name: assignment_details_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE assignment_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: assignment_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE assignment_details_id_seq OWNED BY assignment_details.id;


--
-- Name: assignment_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE assignment_types (
    id integer NOT NULL,
    code character varying(5) NOT NULL,
    name character varying(25) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    company_id integer NOT NULL
);


--
-- Name: assignment_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE assignment_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: assignment_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE assignment_types_id_seq OWNED BY assignment_types.id;


--
-- Name: assignments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE assignments (
    id integer NOT NULL,
    user_id integer,
    start_timestamp date,
    finish_timestamp date,
    released_flag boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    state character varying(50) NOT NULL,
    type character varying(25) NOT NULL,
    priority integer
);


--
-- Name: assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE assignments_id_seq OWNED BY assignments.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE companies (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    address_1 character varying NOT NULL,
    address_2 character varying,
    city character varying(100),
    postal_code character varying,
    country_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    logo_filename character varying(100),
    default_quantity_uom_id integer,
    default_length_uom_id integer,
    default_weight_uom_id integer
);


--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE companies_id_seq OWNED BY companies.id;


--
-- Name: container_contents; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE container_contents (
    id integer NOT NULL,
    container_id integer NOT NULL,
    product_id integer NOT NULL,
    lot_id integer NOT NULL,
    product_status_id integer,
    quantity numeric(8,2) NOT NULL,
    receipt_line_id integer,
    order_line_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: container_contents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE container_contents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: container_contents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE container_contents_id_seq OWNED BY container_contents.id;


--
-- Name: container_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE container_types (
    id integer NOT NULL,
    length numeric(8,2) NOT NULL,
    width numeric(8,2) NOT NULL,
    height numeric(8,2) NOT NULL,
    maximum_weight numeric(8,2) NOT NULL,
    purpose character varying(10),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: container_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE container_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: container_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE container_types_id_seq OWNED BY container_types.id;


--
-- Name: containers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE containers (
    id integer NOT NULL,
    lp character varying(50) NOT NULL,
    container_location_id integer NOT NULL,
    container_location_type character varying NOT NULL,
    container_type_id integer,
    length numeric(8,2),
    width numeric(8,2),
    height numeric(8,2),
    max_weight numeric(8,2),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    receipt_id integer,
    parent_container_id integer,
    state character varying(50) NOT NULL
);


--
-- Name: containers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE containers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: containers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE containers_id_seq OWNED BY containers.id;


--
-- Name: countries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE countries (
    id integer NOT NULL,
    name character varying NOT NULL,
    iso_code character varying(3),
    language character varying(25),
    telephone_country_code integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE countries_id_seq OWNED BY countries.id;


--
-- Name: customer_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE customer_types (
    id integer NOT NULL,
    company_id integer NOT NULL,
    code character varying(5) NOT NULL,
    description character varying(25),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: customer_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE customer_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customer_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE customer_types_id_seq OWNED BY customer_types.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE customers (
    id integer NOT NULL,
    company_id integer NOT NULL,
    name character varying(100) NOT NULL,
    address_1 character varying(100),
    address_2 character varying(100),
    city character varying(50),
    postal_code character varying(10),
    state character varying(50),
    country_id integer,
    telephone character varying(20),
    email character varying(50),
    code character varying(5),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    customer_type_id integer
);


--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE customers_id_seq OWNED BY customers.id;


--
-- Name: dock_doors; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dock_doors (
    id integer NOT NULL,
    name character varying(10) NOT NULL,
    direction character varying(25) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    warehouse_id integer
);


--
-- Name: dock_doors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dock_doors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dock_doors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dock_doors_id_seq OWNED BY dock_doors.id;


--
-- Name: inventory_adjustment_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE inventory_adjustment_types (
    id integer NOT NULL,
    code character varying(10) NOT NULL,
    name character varying(25) NOT NULL,
    description character varying(50),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: inventory_adjustment_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE inventory_adjustment_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_adjustment_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE inventory_adjustment_types_id_seq OWNED BY inventory_adjustment_types.id;


--
-- Name: inventory_adjustments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE inventory_adjustments (
    id integer NOT NULL,
    inventory_adjustment_type_id integer NOT NULL,
    adjustment_type character varying(10) NOT NULL,
    adjustment_quantity numeric(8,2) NOT NULL,
    user_id integer NOT NULL,
    comments text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: inventory_adjustments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE inventory_adjustments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_adjustments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE inventory_adjustments_id_seq OWNED BY inventory_adjustments.id;


--
-- Name: location_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE location_types (
    id integer NOT NULL,
    warehouse_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    length numeric(8,2) NOT NULL,
    width numeric(8,2) NOT NULL,
    height numeric(8,2) NOT NULL,
    maximum_containers integer,
    code character varying(10) NOT NULL,
    name character varying(25) NOT NULL,
    maximum_weight numeric(8,2),
    zone boolean NOT NULL,
    aisle boolean NOT NULL,
    bay boolean NOT NULL,
    level boolean NOT NULL,
    "position" boolean NOT NULL
);


--
-- Name: location_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE location_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: location_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE location_types_id_seq OWNED BY location_types.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE locations (
    id integer NOT NULL,
    warehouse_id integer NOT NULL,
    zone character varying,
    aisle character varying,
    bay character varying,
    level character varying,
    "position" character varying,
    name character varying NOT NULL,
    pick_travel_sequence integer,
    storage_travel_sequence integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    alias character varying(100),
    location_type_id integer NOT NULL,
    available_for_storage boolean DEFAULT false NOT NULL,
    available_for_allocation boolean DEFAULT false NOT NULL,
    allocation_zone_id integer,
    storage_zone_id integer,
    mix_products boolean DEFAULT false NOT NULL,
    collapse_containers boolean DEFAULT false NOT NULL,
    replenishable boolean DEFAULT false NOT NULL
);


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE locations_id_seq OWNED BY locations.id;


--
-- Name: lots; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE lots (
    id integer NOT NULL,
    product_id integer NOT NULL,
    fifo_date date NOT NULL,
    product_status_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(25) NOT NULL
);


--
-- Name: lots_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lots_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lots_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lots_id_seq OWNED BY lots.id;


--
-- Name: order_lines; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE order_lines (
    id integer NOT NULL,
    line_sequence_number integer NOT NULL,
    product_id integer NOT NULL,
    lot_id integer,
    product_status_id integer,
    quantity_ordered integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    order_id integer NOT NULL,
    wave_id integer,
    allocation_strategy_id integer
);


--
-- Name: order_lines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE order_lines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_lines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE order_lines_id_seq OWNED BY order_lines.id;


--
-- Name: order_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE order_types (
    id integer NOT NULL,
    order_type character varying(25) NOT NULL,
    description character varying(50),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    company_id integer NOT NULL
);


--
-- Name: order_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE order_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE order_types_id_seq OWNED BY order_types.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE orders (
    id integer NOT NULL,
    order_number character varying,
    ship_date date,
    customer_id integer,
    received_date date,
    order_type_id integer,
    ship_address_1 character varying,
    ship_address_2 character varying,
    ship_city character varying,
    ship_postal_code character varying,
    ship_state character varying,
    ship_country_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    company_id integer,
    state character varying(50) NOT NULL,
    warehouse_id integer NOT NULL,
    priority integer
);


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE orders_id_seq OWNED BY orders.id;


--
-- Name: product_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE product_categories (
    id integer NOT NULL,
    name character varying(25) NOT NULL,
    description character varying(100) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    company_id integer
);


--
-- Name: product_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE product_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE product_categories_id_seq OWNED BY product_categories.id;


--
-- Name: product_location_assignments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE product_location_assignments (
    id integer NOT NULL,
    product_id integer NOT NULL,
    location_id integer NOT NULL,
    replenishment_at integer NOT NULL,
    maximum_quantity integer NOT NULL,
    warehouse_id integer NOT NULL,
    replenish_to integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    allocation_strategy_id integer NOT NULL
);


--
-- Name: product_location_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE product_location_assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_location_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE product_location_assignments_id_seq OWNED BY product_location_assignments.id;


--
-- Name: product_packages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE product_packages (
    id integer NOT NULL,
    logical_each boolean,
    logical_case boolean,
    logical_pallet boolean,
    length numeric(8,2) NOT NULL,
    width numeric(8,2) NOT NULL,
    height numeric(8,2) NOT NULL,
    quantity integer NOT NULL,
    active boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    product_id integer,
    uom_id integer NOT NULL,
    weight numeric(8,2)
);


--
-- Name: product_packages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE product_packages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_packages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE product_packages_id_seq OWNED BY product_packages.id;


--
-- Name: product_statuses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE product_statuses (
    id integer NOT NULL,
    code character varying(5) NOT NULL,
    description character varying(50) NOT NULL,
    allocatable boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    company_id integer NOT NULL
);


--
-- Name: product_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE product_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE product_statuses_id_seq OWNED BY product_statuses.id;


--
-- Name: product_subcategories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE product_subcategories (
    id integer NOT NULL,
    product_category_id integer NOT NULL,
    name character varying(25) NOT NULL,
    description character varying(100) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    company_id integer
);


--
-- Name: product_subcategories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE product_subcategories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_subcategories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE product_subcategories_id_seq OWNED BY product_subcategories.id;


--
-- Name: product_warehouse_setups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE product_warehouse_setups (
    id integer NOT NULL,
    product_id integer NOT NULL,
    warehouse_id integer NOT NULL,
    product_status_id integer NOT NULL,
    allocation_strategy_id integer,
    storage_strategy_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    stack_height integer,
    lot_management_type character varying(100) NOT NULL
);


--
-- Name: product_warehouse_setups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE product_warehouse_setups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_warehouse_setups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE product_warehouse_setups_id_seq OWNED BY product_warehouse_setups.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE products (
    id integer NOT NULL,
    company_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(200),
    supplier_id integer,
    gtin_number character varying,
    upc_number character varying,
    image_filename character varying(100),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    barcode character varying(100),
    alias character varying(100),
    product_category_id integer,
    product_subcategory_id integer
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE products_id_seq OWNED BY products.id;


--
-- Name: purchase_order_lines; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE purchase_order_lines (
    id integer NOT NULL,
    line_number integer,
    purchase_order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity numeric NOT NULL,
    comments text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    product_status_id integer,
    state character varying(20) NOT NULL
);


--
-- Name: purchase_order_lines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE purchase_order_lines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: purchase_order_lines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE purchase_order_lines_id_seq OWNED BY purchase_order_lines.id;


--
-- Name: purchase_order_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE purchase_order_types (
    id integer NOT NULL,
    purchase_order_type character varying(25) NOT NULL,
    description character varying(50),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    company_id integer NOT NULL
);


--
-- Name: purchase_order_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE purchase_order_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: purchase_order_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE purchase_order_types_id_seq OWNED BY purchase_order_types.id;


--
-- Name: purchase_orders; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE purchase_orders (
    id integer NOT NULL,
    supplier_id integer,
    ship_date date,
    company_id integer,
    purchase_order_number character varying,
    purchase_order_type_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    state character varying(50) NOT NULL
);


--
-- Name: purchase_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE purchase_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: purchase_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE purchase_orders_id_seq OWNED BY purchase_orders.id;


--
-- Name: receipt_lines; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE receipt_lines (
    id integer NOT NULL,
    receipt_id integer NOT NULL,
    lp character varying(50) NOT NULL,
    product_id integer NOT NULL,
    lot_id integer NOT NULL,
    product_status_id integer,
    quantity numeric NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    dock_door_id integer,
    purchase_order_line_id integer,
    state character varying(50) NOT NULL,
    received_at date,
    received_by_user_id integer
);


--
-- Name: receipt_lines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE receipt_lines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: receipt_lines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE receipt_lines_id_seq OWNED BY receipt_lines.id;


--
-- Name: receipt_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE receipt_types (
    id integer NOT NULL,
    name character varying(25) NOT NULL,
    code character varying(50) NOT NULL,
    description character varying(100),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    company_id integer NOT NULL
);


--
-- Name: receipt_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE receipt_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: receipt_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE receipt_types_id_seq OWNED BY receipt_types.id;


--
-- Name: receipts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE receipts (
    id integer NOT NULL,
    supplier_id integer NOT NULL,
    estimated_receipt_date date,
    receipt_type_id integer,
    warehouse_id integer NOT NULL,
    receipt_number character varying(50) NOT NULL,
    ship_date date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    received_at date,
    state character varying(50) NOT NULL
);


--
-- Name: receipts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE receipts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: receipts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE receipts_id_seq OWNED BY receipts.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: shipment_contents; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE shipment_contents (
    id integer NOT NULL,
    shipment_id integer NOT NULL,
    content_id integer,
    content_type character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: shipment_contents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE shipment_contents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shipment_contents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE shipment_contents_id_seq OWNED BY shipment_contents.id;


--
-- Name: shipments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE shipments (
    id integer NOT NULL,
    shipment_number character varying NOT NULL,
    arrival_date date,
    departure_date date,
    direction character varying(25) NOT NULL,
    dock_door_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    state character varying(50) NOT NULL,
    warehouse_id integer NOT NULL
);


--
-- Name: shipments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE shipments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shipments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE shipments_id_seq OWNED BY shipments.id;


--
-- Name: storage_strategies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE storage_strategies (
    id integer NOT NULL,
    code character varying(10) NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(100),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    warehouse_id integer NOT NULL
);


--
-- Name: storage_strategies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE storage_strategies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: storage_strategies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE storage_strategies_id_seq OWNED BY storage_strategies.id;


--
-- Name: storage_strategy_lines; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE storage_strategy_lines (
    id integer NOT NULL,
    order_sequence integer NOT NULL,
    storage_zone_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    check_volume boolean DEFAULT false NOT NULL,
    check_dimensions boolean DEFAULT false NOT NULL,
    check_containers boolean DEFAULT false NOT NULL,
    storage_strategy_id integer NOT NULL
);


--
-- Name: storage_strategy_lines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE storage_strategy_lines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: storage_strategy_lines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE storage_strategy_lines_id_seq OWNED BY storage_strategy_lines.id;


--
-- Name: storage_strategy_rules; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE storage_strategy_rules (
    id integer NOT NULL,
    warehouse_id integer NOT NULL,
    order_sequence_number integer NOT NULL,
    product_category_id integer,
    product_subcategory_id integer,
    uom_id integer,
    supplier_id integer,
    product_status_id integer,
    container_type_id integer,
    storage_strategy_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    purchase_order_type_id integer,
    receipt_type_id integer
);


--
-- Name: storage_strategy_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE storage_strategy_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: storage_strategy_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE storage_strategy_rules_id_seq OWNED BY storage_strategy_rules.id;


--
-- Name: storage_zones; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE storage_zones (
    id integer NOT NULL,
    code character varying(5) NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    warehouse_id integer
);


--
-- Name: storage_zones_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE storage_zones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: storage_zones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE storage_zones_id_seq OWNED BY storage_zones.id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE suppliers (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    address_1 character varying,
    address_2 character varying,
    city character varying,
    postal_code character varying,
    country_id integer,
    state character varying,
    telephone character varying(20) NOT NULL,
    email character varying(100) NOT NULL,
    description character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    company_id integer,
    website character varying(100)
);


--
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE suppliers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: suppliers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE suppliers_id_seq OWNED BY suppliers.id;


--
-- Name: system_parameters; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE system_parameters (
    id integer NOT NULL,
    code character varying(3) NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(100),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    warehouse_id integer,
    value boolean
);


--
-- Name: system_parameters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE system_parameters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: system_parameters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE system_parameters_id_seq OWNED BY system_parameters.id;


--
-- Name: uoms; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE uoms (
    id integer NOT NULL,
    code character varying(5) NOT NULL,
    description character varying(50),
    name character varying(25) NOT NULL,
    type character varying(25),
    discrete boolean DEFAULT false,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    company_id integer
);


--
-- Name: uoms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE uoms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: uoms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE uoms_id_seq OWNED BY uoms.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    username character varying NOT NULL,
    password_digest character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    dob date NOT NULL,
    email character varying(50) NOT NULL,
    "position" character varying(50),
    warehouse_id integer,
    sex character varying(10) NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: warehouses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE warehouses (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description character varying NOT NULL,
    address_1 character varying NOT NULL,
    address_2 character varying,
    city character varying NOT NULL,
    postal_code character varying,
    country_id integer NOT NULL,
    code character varying NOT NULL,
    company_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    state character varying(25)
);


--
-- Name: warehouses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE warehouses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: warehouses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE warehouses_id_seq OWNED BY warehouses.id;


--
-- Name: waves; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE waves (
    id integer NOT NULL,
    wave_number character varying(25) NOT NULL,
    started_running_at timestamp without time zone,
    stopped_running_at timestamp without time zone,
    state character varying(25) NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    warehouse_id integer NOT NULL
);


--
-- Name: waves_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE waves_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: waves_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE waves_id_seq OWNED BY waves.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY allocation_strategies ALTER COLUMN id SET DEFAULT nextval('allocation_strategies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY allocation_strategy_lines ALTER COLUMN id SET DEFAULT nextval('allocation_strategy_lines_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY allocation_strategy_rules ALTER COLUMN id SET DEFAULT nextval('allocation_strategy_rules_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY allocation_zones ALTER COLUMN id SET DEFAULT nextval('allocation_zones_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY assignment_details ALTER COLUMN id SET DEFAULT nextval('assignment_details_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY assignment_types ALTER COLUMN id SET DEFAULT nextval('assignment_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY assignments ALTER COLUMN id SET DEFAULT nextval('assignments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY companies ALTER COLUMN id SET DEFAULT nextval('companies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY container_contents ALTER COLUMN id SET DEFAULT nextval('container_contents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY container_types ALTER COLUMN id SET DEFAULT nextval('container_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY containers ALTER COLUMN id SET DEFAULT nextval('containers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY countries ALTER COLUMN id SET DEFAULT nextval('countries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY customer_types ALTER COLUMN id SET DEFAULT nextval('customer_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY customers ALTER COLUMN id SET DEFAULT nextval('customers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dock_doors ALTER COLUMN id SET DEFAULT nextval('dock_doors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY inventory_adjustment_types ALTER COLUMN id SET DEFAULT nextval('inventory_adjustment_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY inventory_adjustments ALTER COLUMN id SET DEFAULT nextval('inventory_adjustments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY location_types ALTER COLUMN id SET DEFAULT nextval('location_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY locations ALTER COLUMN id SET DEFAULT nextval('locations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY lots ALTER COLUMN id SET DEFAULT nextval('lots_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY order_lines ALTER COLUMN id SET DEFAULT nextval('order_lines_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY order_types ALTER COLUMN id SET DEFAULT nextval('order_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY product_categories ALTER COLUMN id SET DEFAULT nextval('product_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY product_location_assignments ALTER COLUMN id SET DEFAULT nextval('product_location_assignments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY product_packages ALTER COLUMN id SET DEFAULT nextval('product_packages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY product_statuses ALTER COLUMN id SET DEFAULT nextval('product_statuses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY product_subcategories ALTER COLUMN id SET DEFAULT nextval('product_subcategories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY product_warehouse_setups ALTER COLUMN id SET DEFAULT nextval('product_warehouse_setups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY products ALTER COLUMN id SET DEFAULT nextval('products_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY purchase_order_lines ALTER COLUMN id SET DEFAULT nextval('purchase_order_lines_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY purchase_order_types ALTER COLUMN id SET DEFAULT nextval('purchase_order_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY purchase_orders ALTER COLUMN id SET DEFAULT nextval('purchase_orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY receipt_lines ALTER COLUMN id SET DEFAULT nextval('receipt_lines_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY receipt_types ALTER COLUMN id SET DEFAULT nextval('receipt_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY receipts ALTER COLUMN id SET DEFAULT nextval('receipts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY shipment_contents ALTER COLUMN id SET DEFAULT nextval('shipment_contents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY shipments ALTER COLUMN id SET DEFAULT nextval('shipments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY storage_strategies ALTER COLUMN id SET DEFAULT nextval('storage_strategies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY storage_strategy_lines ALTER COLUMN id SET DEFAULT nextval('storage_strategy_lines_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY storage_strategy_rules ALTER COLUMN id SET DEFAULT nextval('storage_strategy_rules_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY storage_zones ALTER COLUMN id SET DEFAULT nextval('storage_zones_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY suppliers ALTER COLUMN id SET DEFAULT nextval('suppliers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY system_parameters ALTER COLUMN id SET DEFAULT nextval('system_parameters_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY uoms ALTER COLUMN id SET DEFAULT nextval('uoms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY warehouses ALTER COLUMN id SET DEFAULT nextval('warehouses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY waves ALTER COLUMN id SET DEFAULT nextval('waves_id_seq'::regclass);


--
-- Name: allocation_strategies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY allocation_strategies
    ADD CONSTRAINT allocation_strategies_pkey PRIMARY KEY (id);


--
-- Name: allocation_strategy_lines_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY allocation_strategy_lines
    ADD CONSTRAINT allocation_strategy_lines_pkey PRIMARY KEY (id);


--
-- Name: allocation_strategy_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY allocation_strategy_rules
    ADD CONSTRAINT allocation_strategy_rules_pkey PRIMARY KEY (id);


--
-- Name: allocation_zones_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY allocation_zones
    ADD CONSTRAINT allocation_zones_pkey PRIMARY KEY (id);


--
-- Name: assignment_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY assignment_details
    ADD CONSTRAINT assignment_details_pkey PRIMARY KEY (id);


--
-- Name: assignment_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY assignment_types
    ADD CONSTRAINT assignment_types_pkey PRIMARY KEY (id);


--
-- Name: assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY assignments
    ADD CONSTRAINT assignments_pkey PRIMARY KEY (id);


--
-- Name: companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: container_contents_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY container_contents
    ADD CONSTRAINT container_contents_pkey PRIMARY KEY (id);


--
-- Name: container_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY container_types
    ADD CONSTRAINT container_types_pkey PRIMARY KEY (id);


--
-- Name: containers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY containers
    ADD CONSTRAINT containers_pkey PRIMARY KEY (id);


--
-- Name: countries_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- Name: customer_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY customer_types
    ADD CONSTRAINT customer_types_pkey PRIMARY KEY (id);


--
-- Name: customers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: dock_doors_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dock_doors
    ADD CONSTRAINT dock_doors_pkey PRIMARY KEY (id);


--
-- Name: inventory_adjustment_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY inventory_adjustment_types
    ADD CONSTRAINT inventory_adjustment_types_pkey PRIMARY KEY (id);


--
-- Name: inventory_adjustments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY inventory_adjustments
    ADD CONSTRAINT inventory_adjustments_pkey PRIMARY KEY (id);


--
-- Name: location_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY location_types
    ADD CONSTRAINT location_types_pkey PRIMARY KEY (id);


--
-- Name: locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: lots_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lots
    ADD CONSTRAINT lots_pkey PRIMARY KEY (id);


--
-- Name: order_lines_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY order_lines
    ADD CONSTRAINT order_lines_pkey PRIMARY KEY (id);


--
-- Name: order_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY order_types
    ADD CONSTRAINT order_types_pkey PRIMARY KEY (id);


--
-- Name: orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: product_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY product_categories
    ADD CONSTRAINT product_categories_pkey PRIMARY KEY (id);


--
-- Name: product_location_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY product_location_assignments
    ADD CONSTRAINT product_location_assignments_pkey PRIMARY KEY (id);


--
-- Name: product_packages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY product_packages
    ADD CONSTRAINT product_packages_pkey PRIMARY KEY (id);


--
-- Name: product_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY product_statuses
    ADD CONSTRAINT product_statuses_pkey PRIMARY KEY (id);


--
-- Name: product_subcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY product_subcategories
    ADD CONSTRAINT product_subcategories_pkey PRIMARY KEY (id);


--
-- Name: product_warehouse_setups_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY product_warehouse_setups
    ADD CONSTRAINT product_warehouse_setups_pkey PRIMARY KEY (id);


--
-- Name: products_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: purchase_order_lines_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY purchase_order_lines
    ADD CONSTRAINT purchase_order_lines_pkey PRIMARY KEY (id);


--
-- Name: purchase_order_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY purchase_order_types
    ADD CONSTRAINT purchase_order_types_pkey PRIMARY KEY (id);


--
-- Name: purchase_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY purchase_orders
    ADD CONSTRAINT purchase_orders_pkey PRIMARY KEY (id);


--
-- Name: receipt_lines_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY receipt_lines
    ADD CONSTRAINT receipt_lines_pkey PRIMARY KEY (id);


--
-- Name: receipt_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY receipt_types
    ADD CONSTRAINT receipt_types_pkey PRIMARY KEY (id);


--
-- Name: receipts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY receipts
    ADD CONSTRAINT receipts_pkey PRIMARY KEY (id);


--
-- Name: shipment_contents_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY shipment_contents
    ADD CONSTRAINT shipment_contents_pkey PRIMARY KEY (id);


--
-- Name: shipments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY shipments
    ADD CONSTRAINT shipments_pkey PRIMARY KEY (id);


--
-- Name: storage_strategies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY storage_strategies
    ADD CONSTRAINT storage_strategies_pkey PRIMARY KEY (id);


--
-- Name: storage_strategy_lines_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY storage_strategy_lines
    ADD CONSTRAINT storage_strategy_lines_pkey PRIMARY KEY (id);


--
-- Name: storage_strategy_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY storage_strategy_rules
    ADD CONSTRAINT storage_strategy_rules_pkey PRIMARY KEY (id);


--
-- Name: storage_zones_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY storage_zones
    ADD CONSTRAINT storage_zones_pkey PRIMARY KEY (id);


--
-- Name: suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- Name: system_parameters_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY system_parameters
    ADD CONSTRAINT system_parameters_pkey PRIMARY KEY (id);


--
-- Name: uoms_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY uoms
    ADD CONSTRAINT uoms_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: warehouses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY warehouses
    ADD CONSTRAINT warehouses_pkey PRIMARY KEY (id);


--
-- Name: waves_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY waves
    ADD CONSTRAINT waves_pkey PRIMARY KEY (id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20100323231443');

INSERT INTO schema_migrations (version) VALUES ('20100324161027');

INSERT INTO schema_migrations (version) VALUES ('20100326160152');

INSERT INTO schema_migrations (version) VALUES ('20100326215017');

INSERT INTO schema_migrations (version) VALUES ('20100326220538');

INSERT INTO schema_migrations (version) VALUES ('20100326221020');

INSERT INTO schema_migrations (version) VALUES ('20100327024505');

INSERT INTO schema_migrations (version) VALUES ('20100402140616');

INSERT INTO schema_migrations (version) VALUES ('20100402140829');

INSERT INTO schema_migrations (version) VALUES ('20100402141715');

INSERT INTO schema_migrations (version) VALUES ('20100402170047');

INSERT INTO schema_migrations (version) VALUES ('20100402170327');

INSERT INTO schema_migrations (version) VALUES ('20100403141836');

INSERT INTO schema_migrations (version) VALUES ('20100405113954');

INSERT INTO schema_migrations (version) VALUES ('20100406011329');

INSERT INTO schema_migrations (version) VALUES ('20100406045858');

INSERT INTO schema_migrations (version) VALUES ('20100406061303');

INSERT INTO schema_migrations (version) VALUES ('20100406061424');

INSERT INTO schema_migrations (version) VALUES ('20100406143151');

INSERT INTO schema_migrations (version) VALUES ('20100406143918');

INSERT INTO schema_migrations (version) VALUES ('20100406181355');

INSERT INTO schema_migrations (version) VALUES ('20100406201755');

INSERT INTO schema_migrations (version) VALUES ('20100407032651');

INSERT INTO schema_migrations (version) VALUES ('20100407033258');

INSERT INTO schema_migrations (version) VALUES ('20100407033742');

INSERT INTO schema_migrations (version) VALUES ('20100407041159');

INSERT INTO schema_migrations (version) VALUES ('20100407190101');

INSERT INTO schema_migrations (version) VALUES ('20100407190518');

INSERT INTO schema_migrations (version) VALUES ('20100407191038');

INSERT INTO schema_migrations (version) VALUES ('20100408143152');

INSERT INTO schema_migrations (version) VALUES ('20100408143526');

INSERT INTO schema_migrations (version) VALUES ('20100408143652');

INSERT INTO schema_migrations (version) VALUES ('20100408160303');

INSERT INTO schema_migrations (version) VALUES ('20100409014613');

INSERT INTO schema_migrations (version) VALUES ('20100409022136');

INSERT INTO schema_migrations (version) VALUES ('20100409023416');

INSERT INTO schema_migrations (version) VALUES ('20100409032442');

INSERT INTO schema_migrations (version) VALUES ('20100409162255');

INSERT INTO schema_migrations (version) VALUES ('20100411035958');

INSERT INTO schema_migrations (version) VALUES ('20100412143245');

INSERT INTO schema_migrations (version) VALUES ('20100413051714');

INSERT INTO schema_migrations (version) VALUES ('20100414053046');

INSERT INTO schema_migrations (version) VALUES ('20100414053244');

INSERT INTO schema_migrations (version) VALUES ('20100416001617');

INSERT INTO schema_migrations (version) VALUES ('20100416005632');

INSERT INTO schema_migrations (version) VALUES ('20100416033517');

INSERT INTO schema_migrations (version) VALUES ('20100417172941');

INSERT INTO schema_migrations (version) VALUES ('20100417175428');

INSERT INTO schema_migrations (version) VALUES ('20100417181337');

INSERT INTO schema_migrations (version) VALUES ('20100417183134');

INSERT INTO schema_migrations (version) VALUES ('20100417183624');

INSERT INTO schema_migrations (version) VALUES ('20100417213124');

INSERT INTO schema_migrations (version) VALUES ('20100417213849');

INSERT INTO schema_migrations (version) VALUES ('20100417221419');

INSERT INTO schema_migrations (version) VALUES ('20100418050838');

INSERT INTO schema_migrations (version) VALUES ('20100419041905');

INSERT INTO schema_migrations (version) VALUES ('20100419134152');

INSERT INTO schema_migrations (version) VALUES ('20100424041712');

INSERT INTO schema_migrations (version) VALUES ('20100511052516');

INSERT INTO schema_migrations (version) VALUES ('20100512124530');

INSERT INTO schema_migrations (version) VALUES ('20100512134112');

INSERT INTO schema_migrations (version) VALUES ('20100512174940');

INSERT INTO schema_migrations (version) VALUES ('20100513032343');

INSERT INTO schema_migrations (version) VALUES ('20100519015814');

INSERT INTO schema_migrations (version) VALUES ('20100519022130');

INSERT INTO schema_migrations (version) VALUES ('20100519025050');

INSERT INTO schema_migrations (version) VALUES ('20100520150258');

INSERT INTO schema_migrations (version) VALUES ('20100520160622');

INSERT INTO schema_migrations (version) VALUES ('20100520161811');

INSERT INTO schema_migrations (version) VALUES ('20100521022910');

INSERT INTO schema_migrations (version) VALUES ('20100521025449');

INSERT INTO schema_migrations (version) VALUES ('20100522190245');

INSERT INTO schema_migrations (version) VALUES ('20100523214610');

INSERT INTO schema_migrations (version) VALUES ('20100527211100');

INSERT INTO schema_migrations (version) VALUES ('20100531154803');

INSERT INTO schema_migrations (version) VALUES ('20100602045504');

INSERT INTO schema_migrations (version) VALUES ('20100603051717');

INSERT INTO schema_migrations (version) VALUES ('20100605141221');

INSERT INTO schema_migrations (version) VALUES ('20100606183049');

INSERT INTO schema_migrations (version) VALUES ('20100606185704');

INSERT INTO schema_migrations (version) VALUES ('20100609035729');

INSERT INTO schema_migrations (version) VALUES ('20100609042443');

INSERT INTO schema_migrations (version) VALUES ('20100613010551');

INSERT INTO schema_migrations (version) VALUES ('20100619212940');

INSERT INTO schema_migrations (version) VALUES ('20100619232306');

INSERT INTO schema_migrations (version) VALUES ('20100619233148');

INSERT INTO schema_migrations (version) VALUES ('20100624042958');

INSERT INTO schema_migrations (version) VALUES ('20100624043459');

INSERT INTO schema_migrations (version) VALUES ('20100629224914');

INSERT INTO schema_migrations (version) VALUES ('20100630034521');

INSERT INTO schema_migrations (version) VALUES ('20100701053842');

INSERT INTO schema_migrations (version) VALUES ('20100701154920');

INSERT INTO schema_migrations (version) VALUES ('20100701155103');

INSERT INTO schema_migrations (version) VALUES ('20100701175108');

INSERT INTO schema_migrations (version) VALUES ('20100702202955');

INSERT INTO schema_migrations (version) VALUES ('20100705182122');

INSERT INTO schema_migrations (version) VALUES ('20100707043152');

INSERT INTO schema_migrations (version) VALUES ('20100708042421');

INSERT INTO schema_migrations (version) VALUES ('20100710025436');

INSERT INTO schema_migrations (version) VALUES ('20100710032807');

INSERT INTO schema_migrations (version) VALUES ('20100710034858');

INSERT INTO schema_migrations (version) VALUES ('20100710041557');

INSERT INTO schema_migrations (version) VALUES ('20100721031405');

INSERT INTO schema_migrations (version) VALUES ('20100724011705');

INSERT INTO schema_migrations (version) VALUES ('20100726000303');

INSERT INTO schema_migrations (version) VALUES ('20100726023914');

INSERT INTO schema_migrations (version) VALUES ('20100823030057');

INSERT INTO schema_migrations (version) VALUES ('20100823034351');

INSERT INTO schema_migrations (version) VALUES ('20100824024011');

INSERT INTO schema_migrations (version) VALUES ('20100828032552');

INSERT INTO schema_migrations (version) VALUES ('20100911190057');

INSERT INTO schema_migrations (version) VALUES ('20100912012716');

INSERT INTO schema_migrations (version) VALUES ('20100912041458');

INSERT INTO schema_migrations (version) VALUES ('20100916035821');

INSERT INTO schema_migrations (version) VALUES ('20101122024411');

INSERT INTO schema_migrations (version) VALUES ('20101122034804');

INSERT INTO schema_migrations (version) VALUES ('20101126034956');

INSERT INTO schema_migrations (version) VALUES ('20101126035453');

INSERT INTO schema_migrations (version) VALUES ('20101126132135');

INSERT INTO schema_migrations (version) VALUES ('20101127053835');

INSERT INTO schema_migrations (version) VALUES ('20101127225819');

INSERT INTO schema_migrations (version) VALUES ('20101127230149');

INSERT INTO schema_migrations (version) VALUES ('20101127234559');

INSERT INTO schema_migrations (version) VALUES ('20101129135200');

INSERT INTO schema_migrations (version) VALUES ('20101215191934');

INSERT INTO schema_migrations (version) VALUES ('20110117035520');

INSERT INTO schema_migrations (version) VALUES ('20110213172245');

INSERT INTO schema_migrations (version) VALUES ('20110214034117');

INSERT INTO schema_migrations (version) VALUES ('20110214042143');

INSERT INTO schema_migrations (version) VALUES ('20110216220313');

INSERT INTO schema_migrations (version) VALUES ('20110216220432');

INSERT INTO schema_migrations (version) VALUES ('20110219225035');

INSERT INTO schema_migrations (version) VALUES ('20110225054158');

INSERT INTO schema_migrations (version) VALUES ('20110226051154');

INSERT INTO schema_migrations (version) VALUES ('20110310215243');

INSERT INTO schema_migrations (version) VALUES ('20110310215302');

INSERT INTO schema_migrations (version) VALUES ('20110311231506');

INSERT INTO schema_migrations (version) VALUES ('20110404024618');

INSERT INTO schema_migrations (version) VALUES ('20110410051047');

INSERT INTO schema_migrations (version) VALUES ('20110424174657');

INSERT INTO schema_migrations (version) VALUES ('20110424175120');

INSERT INTO schema_migrations (version) VALUES ('20110424200212');

INSERT INTO schema_migrations (version) VALUES ('20110424205604');

INSERT INTO schema_migrations (version) VALUES ('20110426041945');

INSERT INTO schema_migrations (version) VALUES ('20110426042011');

INSERT INTO schema_migrations (version) VALUES ('20110701161936');

INSERT INTO schema_migrations (version) VALUES ('20110718024033');

INSERT INTO schema_migrations (version) VALUES ('20110813043915');

INSERT INTO schema_migrations (version) VALUES ('20110906202829');

